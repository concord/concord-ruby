#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'bolt_types'

module Concord
  module Thrift
    module ComputationService
      class Client
        include ::Thrift::Client

        def init()
          send_init()
          return recv_init()
        end

        def send_init()
          send_message('init', Init_args)
        end

        def recv_init()
          result = receive_message(Init_result)
          return result.success unless result.success.nil?
          raise result.e unless result.e.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'init failed: unknown result')
        end

        def boltProcessRecords(records)
          send_boltProcessRecords(records)
          return recv_boltProcessRecords()
        end

        def send_boltProcessRecords(records)
          send_message('boltProcessRecords', BoltProcessRecords_args, :records => records)
        end

        def recv_boltProcessRecords()
          result = receive_message(BoltProcessRecords_result)
          return result.success unless result.success.nil?
          raise result.e unless result.e.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'boltProcessRecords failed: unknown result')
        end

        def boltProcessTimer(key, time)
          send_boltProcessTimer(key, time)
          return recv_boltProcessTimer()
        end

        def send_boltProcessTimer(key, time)
          send_message('boltProcessTimer', BoltProcessTimer_args, :key => key, :time => time)
        end

        def recv_boltProcessTimer()
          result = receive_message(BoltProcessTimer_result)
          return result.success unless result.success.nil?
          raise result.e unless result.e.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'boltProcessTimer failed: unknown result')
        end

        def boltMetadata()
          send_boltMetadata()
          return recv_boltMetadata()
        end

        def send_boltMetadata()
          send_message('boltMetadata', BoltMetadata_args)
        end

        def recv_boltMetadata()
          result = receive_message(BoltMetadata_result)
          return result.success unless result.success.nil?
          raise result.e unless result.e.nil?
          raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'boltMetadata failed: unknown result')
        end

      end

      class Processor
        include ::Thrift::Processor

        def process_init(seqid, iprot, oprot)
          args = read_args(iprot, Init_args)
          result = Init_result.new()
          begin
            result.success = @handler.init()
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'init', seqid)
        end

        def process_boltProcessRecords(seqid, iprot, oprot)
          args = read_args(iprot, BoltProcessRecords_args)
          result = BoltProcessRecords_result.new()
          begin
            result.success = @handler.boltProcessRecords(args.records)
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'boltProcessRecords', seqid)
        end

        def process_boltProcessTimer(seqid, iprot, oprot)
          args = read_args(iprot, BoltProcessTimer_args)
          result = BoltProcessTimer_result.new()
          begin
            result.success = @handler.boltProcessTimer(args.key, args.time)
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'boltProcessTimer', seqid)
        end

        def process_boltMetadata(seqid, iprot, oprot)
          args = read_args(iprot, BoltMetadata_args)
          result = BoltMetadata_result.new()
          begin
            result.success = @handler.boltMetadata()
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'boltMetadata', seqid)
        end

      end

      # HELPER FUNCTIONS AND STRUCTURES

      class Init_args
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Init_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        E = 1

        FIELDS = {
          SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Concord::Thrift::ComputationTx},
          E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::Concord::Thrift::BoltError}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltProcessRecords_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        RECORDS = 1

        FIELDS = {
          RECORDS => {:type => ::Thrift::Types::LIST, :name => 'records', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::Record}}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltProcessRecords_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        E = 1

        FIELDS = {
          SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Concord::Thrift::ComputationTx}},
          E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::Concord::Thrift::BoltError}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltProcessTimer_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        KEY = 1
        TIME = 2

        FIELDS = {
          KEY => {:type => ::Thrift::Types::STRING, :name => 'key'},
          TIME => {:type => ::Thrift::Types::I64, :name => 'time'}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltProcessTimer_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        E = 1

        FIELDS = {
          SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Concord::Thrift::ComputationTx},
          E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::Concord::Thrift::BoltError}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltMetadata_args
        include ::Thrift::Struct, ::Thrift::Struct_Union

        FIELDS = {

        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class BoltMetadata_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        SUCCESS = 0
        E = 1

        FIELDS = {
          SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Concord::Thrift::ComputationMetadata},
          E => {:type => ::Thrift::Types::STRUCT, :name => 'e', :class => ::Concord::Thrift::BoltError}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

    end

  end
end
