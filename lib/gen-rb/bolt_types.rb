#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Concord
  module Thrift
    module BackPressure
      NONE = 0
      ENQUEUE = 1
      DROP_HEAD = 2
      DROP_TAIL = 3
      BLOCK_SENDER = 4
      VALUE_MAP = {0 => "NONE", 1 => "ENQUEUE", 2 => "DROP_HEAD", 3 => "DROP_TAIL", 4 => "BLOCK_SENDER"}
      VALID_VALUES = Set.new([NONE, ENQUEUE, DROP_HEAD, DROP_TAIL, BLOCK_SENDER]).freeze
    end

    module StreamGrouping
      ROUND_ROBIN = 0
      SHUFFLE = 1
      GROUP_BY = 2
      LOCAL = 3
      CUSTOM = 100
      VALUE_MAP = {0 => "ROUND_ROBIN", 1 => "SHUFFLE", 2 => "GROUP_BY", 3 => "LOCAL", 100 => "CUSTOM"}
      VALID_VALUES = Set.new([ROUND_ROBIN, SHUFFLE, GROUP_BY, LOCAL, CUSTOM]).freeze
    end

    module Signal
      START = 0
      ACTIVE = 1
      INACTIVE = 2
      SHUTDOWN = 3
      KILL = 4
      VALUE_MAP = {0 => "START", 1 => "ACTIVE", 2 => "INACTIVE", 3 => "SHUTDOWN", 4 => "KILL"}
      VALID_VALUES = Set.new([START, ACTIVE, INACTIVE, SHUTDOWN, KILL]).freeze
    end

    module RecordFlags
      CLIENT_RECORD = 1
      FRAMEWORK_RECORD = 2
      VALUE_MAP = {1 => "CLIENT_RECORD", 2 => "FRAMEWORK_RECORD"}
      VALID_VALUES = Set.new([CLIENT_RECORD, FRAMEWORK_RECORD]).freeze
    end

    module AnnotationType
      CLIENT_SEND = 0
      CLIENT_RECV = 1
      SERVER_SEND = 2
      SERVER_RECV = 3
      VALUE_MAP = {0 => "CLIENT_SEND", 1 => "CLIENT_RECV", 2 => "SERVER_SEND", 3 => "SERVER_RECV"}
      VALID_VALUES = Set.new([CLIENT_SEND, CLIENT_RECV, SERVER_SEND, SERVER_RECV]).freeze
    end

    class BoltError < ::Thrift::Exception
      include ::Thrift::Struct, ::Thrift::Struct_Union
      REASON = 1
      CONTEXT = 2
      TIME = 3

      FIELDS = {
        REASON => {:type => ::Thrift::Types::STRING, :name => 'reason'},
        CONTEXT => {:type => ::Thrift::Types::STRING, :name => 'context'},
        TIME => {:type => ::Thrift::Types::I64, :name => 'time'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Endpoint
      include ::Thrift::Struct, ::Thrift::Struct_Union
      IP = 1
      PORT = 2

      FIELDS = {
        IP => {:type => ::Thrift::Types::STRING, :name => 'ip'},
        PORT => {:type => ::Thrift::Types::I16, :name => 'port'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class StreamMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      NAME = 1
      GROUPING = 2

      FIELDS = {
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        GROUPING => {:type => ::Thrift::Types::I32, :name => 'grouping', :default =>         1, :enum_class => ::Concord::Thrift::StreamGrouping}
      }

      def struct_fields; FIELDS; end

      def validate
        unless @grouping.nil? || ::Concord::Thrift::StreamGrouping::VALID_VALUES.include?(@grouping)
          raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field grouping!')
        end
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ComputationMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      NAME = 1
      TASKID = 2
      ISTREAMS = 3
      OSTREAMS = 4
      PROXYENDPOINT = 5

      FIELDS = {
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        TASKID => {:type => ::Thrift::Types::STRING, :name => 'taskId'},
        ISTREAMS => {:type => ::Thrift::Types::LIST, :name => 'istreams', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::StreamMetadata}},
        OSTREAMS => {:type => ::Thrift::Types::LIST, :name => 'ostreams', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::StreamMetadata}},
        PROXYENDPOINT => {:type => ::Thrift::Types::STRUCT, :name => 'proxyEndpoint', :class => ::Concord::Thrift::Endpoint}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ExecutorTaskInfoHelper
      include ::Thrift::Struct, ::Thrift::Struct_Union
      FRAMEWORKLOGGINGLEVEL = 1
      USER = 2
      FRAMEWORKVMODULE = 3
      SCHEDULER = 4
      PROXY = 5
      CLIENT = 6
      TRACEAGGREGATOR = 7
      EXECNAME = 8
      FOLDER = 9
      COMPUTATIONALIASNAME = 10
      CLIENTARGUMENTS = 11
      ENVIRONMENTEXTRA = 12
      DOCKERCONTAINER = 13

      FIELDS = {
        FRAMEWORKLOGGINGLEVEL => {:type => ::Thrift::Types::I32, :name => 'frameworkLoggingLevel', :default => 1},
        USER => {:type => ::Thrift::Types::STRING, :name => 'user'},
        FRAMEWORKVMODULE => {:type => ::Thrift::Types::STRING, :name => 'frameworkVModule'},
        SCHEDULER => {:type => ::Thrift::Types::STRUCT, :name => 'scheduler', :class => ::Concord::Thrift::Endpoint},
        PROXY => {:type => ::Thrift::Types::STRUCT, :name => 'proxy', :class => ::Concord::Thrift::Endpoint},
        CLIENT => {:type => ::Thrift::Types::STRUCT, :name => 'client', :class => ::Concord::Thrift::Endpoint},
        TRACEAGGREGATOR => {:type => ::Thrift::Types::STRUCT, :name => 'traceAggregator', :class => ::Concord::Thrift::Endpoint},
        EXECNAME => {:type => ::Thrift::Types::STRING, :name => 'execName'},
        FOLDER => {:type => ::Thrift::Types::STRING, :name => 'folder'},
        COMPUTATIONALIASNAME => {:type => ::Thrift::Types::STRING, :name => 'computationAliasName'},
        CLIENTARGUMENTS => {:type => ::Thrift::Types::LIST, :name => 'clientArguments', :element => {:type => ::Thrift::Types::STRING}},
        ENVIRONMENTEXTRA => {:type => ::Thrift::Types::LIST, :name => 'environmentExtra', :element => {:type => ::Thrift::Types::STRING}},
        DOCKERCONTAINER => {:type => ::Thrift::Types::STRING, :name => 'dockerContainer'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class PhysicalComputationMetdata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      TASKID = 1
      SLAVEID = 2
      CPUS = 3
      MEM = 4
      DISK = 5
      TASKHELPER = 6
      NEEDSRECONCILIATION = 7

      FIELDS = {
        TASKID => {:type => ::Thrift::Types::STRING, :name => 'taskId'},
        SLAVEID => {:type => ::Thrift::Types::STRING, :name => 'slaveId'},
        CPUS => {:type => ::Thrift::Types::I32, :name => 'cpus'},
        MEM => {:type => ::Thrift::Types::I32, :name => 'mem'},
        DISK => {:type => ::Thrift::Types::I32, :name => 'disk'},
        TASKHELPER => {:type => ::Thrift::Types::STRUCT, :name => 'taskHelper', :class => ::Concord::Thrift::ExecutorTaskInfoHelper},
        NEEDSRECONCILIATION => {:type => ::Thrift::Types::BOOL, :name => 'needsReconciliation'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class PhysicalComputationLayout
      include ::Thrift::Struct, ::Thrift::Struct_Union
      NAME = 1
      ISTREAMS = 2
      OSTREAMS = 3
      NODES = 4

      FIELDS = {
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        ISTREAMS => {:type => ::Thrift::Types::LIST, :name => 'istreams', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::StreamMetadata}},
        OSTREAMS => {:type => ::Thrift::Types::LIST, :name => 'ostreams', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::StreamMetadata}},
        NODES => {:type => ::Thrift::Types::LIST, :name => 'nodes', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::PhysicalComputationMetdata}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class SchedulerMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      ENDPOINT = 1
      VERSION = 2

      FIELDS = {
        ENDPOINT => {:type => ::Thrift::Types::STRUCT, :name => 'endpoint', :class => ::Concord::Thrift::Endpoint},
        VERSION => {:type => ::Thrift::Types::I32, :name => 'version'}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class TopologyMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      VERSION = 1
      HASH = 2
      COMPUTATIONS = 3

      FIELDS = {
        VERSION => {:type => ::Thrift::Types::I32, :name => 'version', :default => 0},
        HASH => {:type => ::Thrift::Types::STRING, :name => 'hash'},
        COMPUTATIONS => {:type => ::Thrift::Types::MAP, :name => 'computations', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::PhysicalComputationLayout}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class RecordMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      TRACEID = 1
      SOURCESPANID = 2
      FLAGS = 3
      STREAM = 4
      TIMESTAMP = 5

      FIELDS = {
        TRACEID => {:type => ::Thrift::Types::I64, :name => 'traceId', :default => 0},
        SOURCESPANID => {:type => ::Thrift::Types::I64, :name => 'sourceSpanId', :default => 0},
        FLAGS => {:type => ::Thrift::Types::I32, :name => 'flags', :default => 0},
        STREAM => {:type => ::Thrift::Types::I64, :name => 'stream', :default => 0},
        TIMESTAMP => {:type => ::Thrift::Types::I64, :name => 'timestamp', :default => 0}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Record
      include ::Thrift::Struct, ::Thrift::Struct_Union
      META = 1
      TIME = 2
      KEY = 3
      DATA = 4
      USERSTREAM = 5

      FIELDS = {
        META => {:type => ::Thrift::Types::STRUCT, :name => 'meta', :class => ::Concord::Thrift::RecordMetadata},
        TIME => {:type => ::Thrift::Types::I64, :name => 'time', :default => 0},
        KEY => {:type => ::Thrift::Types::STRING, :name => 'key', :binary => true},
        DATA => {:type => ::Thrift::Types::STRING, :name => 'data', :binary => true},
        USERSTREAM => {:type => ::Thrift::Types::STRING, :name => 'userStream', :binary => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class ComputationTx
      include ::Thrift::Struct, ::Thrift::Struct_Union
      ID = 1
      RECORDS = 2
      TIMERS = 3

      FIELDS = {
        ID => {:type => ::Thrift::Types::I64, :name => 'id', :default => 0},
        RECORDS => {:type => ::Thrift::Types::LIST, :name => 'records', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::Record}},
        TIMERS => {:type => ::Thrift::Types::MAP, :name => 'timers', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::I64}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class RichStream
      include ::Thrift::Struct, ::Thrift::Struct_Union
      STREAM = 1
      COMPUTATIONNAME = 2
      ENDPOINTS = 3

      FIELDS = {
        STREAM => {:type => ::Thrift::Types::STRUCT, :name => 'stream', :class => ::Concord::Thrift::StreamMetadata},
        COMPUTATIONNAME => {:type => ::Thrift::Types::STRING, :name => 'computationName'},
        ENDPOINTS => {:type => ::Thrift::Types::LIST, :name => 'endpoints', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::Endpoint}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class BoltComputationRequest
      include ::Thrift::Struct, ::Thrift::Struct_Union
      NAME = 1
      INSTANCES = 2
      CPUS = 3
      MEM = 4
      DISK = 5
      TASKHELPER = 6
      FORCEUPDATEBINARY = 7
      SLUG = 8

      FIELDS = {
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        INSTANCES => {:type => ::Thrift::Types::I64, :name => 'instances', :default => 1},
        CPUS => {:type => ::Thrift::Types::I64, :name => 'cpus', :default => 1},
        MEM => {:type => ::Thrift::Types::I64, :name => 'mem', :default => 2048},
        DISK => {:type => ::Thrift::Types::I64, :name => 'disk', :default => 10240},
        TASKHELPER => {:type => ::Thrift::Types::STRUCT, :name => 'taskHelper', :class => ::Concord::Thrift::ExecutorTaskInfoHelper},
        FORCEUPDATEBINARY => {:type => ::Thrift::Types::BOOL, :name => 'forceUpdateBinary'},
        SLUG => {:type => ::Thrift::Types::STRING, :name => 'slug', :binary => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Annotation
      include ::Thrift::Struct, ::Thrift::Struct_Union
      TIMESTAMP = 1
      TYPE = 2
      KEY = 3
      VALUE = 4
      HOST = 5

      FIELDS = {
        TIMESTAMP => {:type => ::Thrift::Types::I64, :name => 'timestamp'},
        TYPE => {:type => ::Thrift::Types::I32, :name => 'type', :enum_class => ::Concord::Thrift::AnnotationType},
        KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
        VALUE => {:type => ::Thrift::Types::STRING, :name => 'value', :binary => true},
        HOST => {:type => ::Thrift::Types::STRUCT, :name => 'host', :class => ::Concord::Thrift::Endpoint}
      }

      def struct_fields; FIELDS; end

      def validate
        unless @type.nil? || ::Concord::Thrift::AnnotationType::VALID_VALUES.include?(@type)
          raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field type!')
        end
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Span
      include ::Thrift::Struct, ::Thrift::Struct_Union
      TRACEID = 1
      ID = 2
      PARENTID = 3
      NAME = 4
      ANNOTATIONS = 5

      FIELDS = {
        TRACEID => {:type => ::Thrift::Types::I64, :name => 'traceId'},
        ID => {:type => ::Thrift::Types::I64, :name => 'id'},
        PARENTID => {:type => ::Thrift::Types::I64, :name => 'parentId'},
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        ANNOTATIONS => {:type => ::Thrift::Types::LIST, :name => 'annotations', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::Annotation}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Trace
      include ::Thrift::Struct, ::Thrift::Struct_Union
      ID = 1
      SPANS = 2

      FIELDS = {
        ID => {:type => ::Thrift::Types::I64, :name => 'id'},
        SPANS => {:type => ::Thrift::Types::LIST, :name => 'spans', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::Span}}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end
end
