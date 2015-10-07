require 'thrift'
require 'optparse'
require 'bolt_proxy_service'
require 'computation_service'
require 'bolt_types'
require 'bolt_constants'

module Concord
  # Wrapper over the ComputationMetadata object from the thrift interface
  class Metadata
    attr_accessor :name, :istreams, :ostreams

    # Initialize a new `Metadata` object
    # @param name [String] The globally unique identifier of the application
    # @param istreams [Array] An array of input streams. These can be formatted
    # as either a `String` identifying the stream or an `Array` of length two,
    # in which the first parameter is the `String` identifier and the second
    # parameter is a `StreamGrouping` defining how incoming records should be
    # routed.
    # @param ostreams [Array] An array of `String` stream identifiers that this
    # computation may produce records on.
    def initialize(name: nil, istreams: [], ostreams: [])
      self.name = name
      self.istreams = istreams
      self.ostreams = ostreams
    end
  end

  # Transactional wrapper for proxy <=> client interactions
  class ComputationContext
    attr_accessor :transaction, :computation

    # Initialize a new `ComputationContext`
    # @param computation [Object] The user-defined computation
    def initialize(computation)
      self.computation = computation
      self.transaction = ::Concord::Thrift::ComputationTx.new
      self.transaction.records = []
      self.transaction.timers = {}
    end

    # Produce a record on `stream` with `key` and `value`
    # @param stream [String] Globally unique name of string
    # @param key [String] Key to group by on stream (pending grouping)
    # @param value [String] Binary blob to pass downstream with tuple
    def produce_record(stream, key, value)
      r = ::Concord::Thrift::Record.new
      r.meta = ::Concord::Thrift::RecordMetadata.new
      r.key = key
      r.data = value
      r.userStream = stream
      transaction.records.push(r)
    end

    # Set a timer to trigger a callback in the future
    # @param key [String] Name of the timer. This parameter will be passed to
    # the `process_timer` callback to identify the specific callback.
    # @param time [FixNum] Integer representing the time (in milliseconds) at
    #        which the callback should be triggered.
    def set_timer(key, time)
      transaction.timers[key] = time
    end

    # Retrieve a binary blob stored in the proxy state
    # @param key [String] Key to fetch from data store
    # @return [String] Binary blob of data
    def get_state(key)
      computation.get_state(key)
    end

    # Store a binary blob, identified by a key, in the proxy state
    # @param key [String] Key to set in data store
    # @param value [String] Binary blob
    def set_state(key, value)
      computation.set_state(key, value)
    end
  end

  # Thrift service definition. Wraps a user-defined computation.
  class Computation
    attr_accessor :handler, :proxy_host, :proxy_port

    # Initialize a new `Computation` and register it with the proxy
    # @param handler [Object] The user-defined computation
    # @param proxy_host [String] The address the proxy is listening on
    # @param proxy_port [FixNum] The port the proxy is listening on
    def initialize(handler: nil, proxy_host: nil, proxy_port: nil)
      self.handler = handler
      self.proxy_host = proxy_host
      self.proxy_port = proxy_port
    end

    def register_with_scheduler
      log_failure do
        proxy.registerWithScheduler(boltMetadata)
      end
    end

    # Initialize a new `Computation` and start serving it. This is the only
    # method directly called by users.
    # @param computation [Object] The user-defined computation
    def self.serve(computation)
      listen_address = ENV[::Concord::Thrift::KConcordEnvKeyClientListenAddr]
      proxy_address = ENV[::Concord::Thrift::KConcordEnvKeyClientProxyAddr]
      listen_host, listen_port = listen_address.split(':')
      proxy_host, proxy_port = proxy_address.split(':')

      handler = self.new(handler: computation,
                         proxy_host: proxy_host,
                         proxy_port: Integer(proxy_port))

      processor = Thrift::ComputationService::Processor.new(handler)
      transport = ::Thrift::ServerSocket.new(listen_host, Integer(listen_port))
      transport_factory = ::Thrift::FramedTransportFactory.new
      protocol_factory = ::Thrift::BinaryProtocolAcceleratedFactory.new
      # The reason the client computations MUST use a simple blocking server
      # is that we have process_timer and process_record both which exec as
      # a callback in the work thread pool which means that you might get
      # 2 callbacks whichs makes the code multi threaded - we guarantee single
      # thread for each callback
      server = ::Thrift::SimpleServer.new(processor,
                                          transport,
                                          transport_factory,
                                          protocol_factory)
      # Register with localhost proxy. Note that this method is `oneway'
      # which means after final TCP 'ack' it finishes.
      handler.register_with_scheduler
      server.serve
    end

    # Process records from upstream. Wraps the user method in transactions,
    # which are returned to the proxy upon completion.
    # @param records [Concord::Thrift::Record] The record to process
    def boltProcessRecords(records)
      txs = []
      records.each do |record|
        ctx = ComputationContext.new(self)
        log_failure do
          handler.process_record(ctx, record)
        end
        txs.push(ctx.transaction)
      end
      txs
    end

    # Process a timer callback from the proxy. Wraps the user method in a
    # transaction, which is returned to the proxy upon completion.
    # @param key [String] Callback identifier
    # @param time [FixNum] Time this callback was scheduled to trigger.
    def boltProcessTimer(key, time)
      ctx = ComputationContext.new(self)
      log_failure do
        handler.process_timer(ctx, key, time)
      end
      ctx.transaction
    end

    # The initialization function, called when the framework is ready to start
    # sending the computation records. Wraps the user method in a transaction,
    # which is returned to the proxy upon completion.
    def init
      ctx = ComputationContext.new(self)
      log_failure do
        handler.init(ctx)
      end
      ctx.transaction
    end

    # @return [Concord::Thrift::ComputationMetadata] The user-defined computation metadata.
    def boltMetadata
      metadata = nil
      log_failure do
        metadata = handler.metadata
      end
      enrich_metadata(metadata)
    end

    # Retrieve a binary blob stored in the proxy state
    # @param key [String] Key to fetch from data store
    # @return [String] Binary blob of data
    def get_state(key)
      proxy.getState(key)
    end

    # Store a binary blob, identified by a key, in the proxy state
    # @param key [String] Key to set in data store
    # @param value [String] Binary blob
    def set_state(key, value)
      proxy.setState(key, value)
    end

    private

    def log(msg, handle: $stderr)
      handle.puts msg
      handle.flush
    end

    def log_failure(&block)
      begin
        block.call
      rescue => e
        log e.message
        log e.backtrace.join("\n")
        raise e
      end
    end

    def proxy
      if @proxy.nil? || !@proxy_socket.open?
        @proxy_socket = ::Thrift::Socket.new(proxy_host, proxy_port)
        transport = ::Thrift::FramedTransport.new(@proxy_socket)
        protocol = ::Thrift::BinaryProtocol.new(transport)
        @proxy = ::Concord::Thrift::BoltProxyService::Client.new(protocol)
        transport.open
      end

      @proxy
    end

    def enrich_metadata(metadata)
      def enrich_stream(stream)
        sm = ::Concord::Thrift::StreamMetadata.new
        if stream.is_a?(Array)
          sm.name = stream.first
          sm.grouping = stream.last
        else
          sm.name = stream
        end
        sm
      end

      cm = ::Concord::Thrift::ComputationMetadata.new
      cm.name = metadata.name
      cm.istreams = metadata.istreams.map { |x| enrich_stream(x) }
      cm.ostreams = metadata.ostreams
      cm.proxyEndpoint = ::Concord::Thrift::Endpoint.new
      cm.proxyEndpoint.ip = proxy_host
      cm.proxyEndpoint.port = proxy_port
      cm
    end
  end
end
