require 'concord'
require 'concord/utils'

class WordCountSink
  def init(ctx)
  end

  def process_record(ctx, record)
    log("received record with key (#{record.key}) and value (#{record.data})")
  end

  def metadata
    Concord::Metadata.new(name: 'test-sink', istreams: [
      ['test', Concord::Thrift::StreamGrouping::GROUP_BY]
    ])
  end

  private
  
  def log(msg)
    $stderr.puts msg
    $stderr.flush
  end
end

Concord::Computation.serve(WordCountSink.new)

