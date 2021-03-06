#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'bolt_types'

module Concord
  module Thrift
    module BoltPipeService
      class Client
        include ::Thrift::Client

        def dispatchRecords(records)
          send_dispatchRecords(records)
          recv_dispatchRecords()
        end

        def send_dispatchRecords(records)
          send_message('dispatchRecords', DispatchRecords_args, :records => records)
        end

        def recv_dispatchRecords()
          result = receive_message(DispatchRecords_result)
          raise result.e unless result.e.nil?
          return
        end

      end

      class Processor
        include ::Thrift::Processor

        def process_dispatchRecords(seqid, iprot, oprot)
          args = read_args(iprot, DispatchRecords_args)
          result = DispatchRecords_result.new()
          begin
            @handler.dispatchRecords(args.records)
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'dispatchRecords', seqid)
        end

      end

      # HELPER FUNCTIONS AND STRUCTURES

      class DispatchRecords_args
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

      class DispatchRecords_result
        include ::Thrift::Struct, ::Thrift::Struct_Union
        E = 1

        FIELDS = {
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
