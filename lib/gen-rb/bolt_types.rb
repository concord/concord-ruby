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
        PORT => {:type => ::Thrift::Types::I32, :name => 'port'}
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
        OSTREAMS => {:type => ::Thrift::Types::LIST, :name => 'ostreams', :element => {:type => ::Thrift::Types::STRING}},
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
      ROUTER = 14
      EXECNAME = 7
      FOLDER = 8
      COMPUTATIONALIASNAME = 9
      CLIENTARGUMENTS = 10
      ENVIRONMENTEXTRA = 11
      DOCKERCONTAINER = 12
      RETRIES = 13

      FIELDS = {
        FRAMEWORKLOGGINGLEVEL => {:type => ::Thrift::Types::I32, :name => 'frameworkLoggingLevel', :default => 1},
        USER => {:type => ::Thrift::Types::STRING, :name => 'user'},
        FRAMEWORKVMODULE => {:type => ::Thrift::Types::STRING, :name => 'frameworkVModule'},
        SCHEDULER => {:type => ::Thrift::Types::STRUCT, :name => 'scheduler', :class => ::Concord::Thrift::Endpoint},
        PROXY => {:type => ::Thrift::Types::STRUCT, :name => 'proxy', :class => ::Concord::Thrift::Endpoint},
        CLIENT => {:type => ::Thrift::Types::STRUCT, :name => 'client', :class => ::Concord::Thrift::Endpoint},
        ROUTER => {:type => ::Thrift::Types::STRUCT, :name => 'router', :class => ::Concord::Thrift::Endpoint},
        EXECNAME => {:type => ::Thrift::Types::STRING, :name => 'execName'},
        FOLDER => {:type => ::Thrift::Types::STRING, :name => 'folder'},
        COMPUTATIONALIASNAME => {:type => ::Thrift::Types::STRING, :name => 'computationAliasName'},
        CLIENTARGUMENTS => {:type => ::Thrift::Types::LIST, :name => 'clientArguments', :element => {:type => ::Thrift::Types::STRING}},
        ENVIRONMENTEXTRA => {:type => ::Thrift::Types::LIST, :name => 'environmentExtra', :element => {:type => ::Thrift::Types::STRING}},
        DOCKERCONTAINER => {:type => ::Thrift::Types::STRING, :name => 'dockerContainer'},
        RETRIES => {:type => ::Thrift::Types::I32, :name => 'retries', :default => 0}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

    class PhysicalComputationMetadata
      include ::Thrift::Struct, ::Thrift::Struct_Union
      TASKID = 1
      SLAVEID = 2
      CPUS = 3
      MEM = 4
      DISK = 5
      TASKHELPER = 6
      NEEDSRECONCILIATION = 7
      KILLED = 8

      FIELDS = {
        TASKID => {:type => ::Thrift::Types::STRING, :name => 'taskId'},
        SLAVEID => {:type => ::Thrift::Types::STRING, :name => 'slaveId'},
        CPUS => {:type => ::Thrift::Types::DOUBLE, :name => 'cpus'},
        MEM => {:type => ::Thrift::Types::I32, :name => 'mem'},
        DISK => {:type => ::Thrift::Types::I32, :name => 'disk'},
        TASKHELPER => {:type => ::Thrift::Types::STRUCT, :name => 'taskHelper', :class => ::Concord::Thrift::ExecutorTaskInfoHelper},
        NEEDSRECONCILIATION => {:type => ::Thrift::Types::BOOL, :name => 'needsReconciliation'},
        KILLED => {:type => ::Thrift::Types::BOOL, :name => 'killed'}
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
        OSTREAMS => {:type => ::Thrift::Types::LIST, :name => 'ostreams', :element => {:type => ::Thrift::Types::STRING}},
        NODES => {:type => ::Thrift::Types::LIST, :name => 'nodes', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::PhysicalComputationMetadata}}
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
      COMPUTATIONS = 2
      FRAMEWORKID = 3
      KAFKABROKERLIST = 4

      FIELDS = {
        VERSION => {:type => ::Thrift::Types::I32, :name => 'version', :default => 0},
        COMPUTATIONS => {:type => ::Thrift::Types::MAP, :name => 'computations', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::PhysicalComputationLayout}},
        FRAMEWORKID => {:type => ::Thrift::Types::STRING, :name => 'frameworkID'},
        KAFKABROKERLIST => {:type => ::Thrift::Types::STRING, :name => 'kafkaBrokerList'}
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
      FORCEPULLCONTAINER = 9

      FIELDS = {
        NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
        INSTANCES => {:type => ::Thrift::Types::I64, :name => 'instances', :default => 1},
        CPUS => {:type => ::Thrift::Types::DOUBLE, :name => 'cpus', :default => 0.1},
        MEM => {:type => ::Thrift::Types::I64, :name => 'mem', :default => 2048},
        DISK => {:type => ::Thrift::Types::I64, :name => 'disk', :default => 10240},
        TASKHELPER => {:type => ::Thrift::Types::STRUCT, :name => 'taskHelper', :class => ::Concord::Thrift::ExecutorTaskInfoHelper},
        FORCEUPDATEBINARY => {:type => ::Thrift::Types::BOOL, :name => 'forceUpdateBinary'},
        SLUG => {:type => ::Thrift::Types::STRING, :name => 'slug', :binary => true},
        FORCEPULLCONTAINER => {:type => ::Thrift::Types::BOOL, :name => 'forcePullContainer', :default => true}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end
end
