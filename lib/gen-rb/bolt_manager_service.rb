#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'bolt_types'

module Concord
  module Thrift
    module BoltManagerService
      class Client
        include ::Thrift::Client

        def setEnvironmentVar(name, value)
          send_setEnvironmentVar(name, value)
          recv_setEnvironmentVar()
        end

        def send_setEnvironmentVar(name, value)
          send_message('setEnvironmentVar', SetEnvironmentVar_args, :name => name, :value => value)
        end

        def recv_setEnvironmentVar()
          result = receive_message(SetEnvironmentVar_result)
          raise result.e unless result.e.nil?
          return
        end

        def signal(topologyId, s)
          send_signal(topologyId, s)
          recv_signal()
        end

        def send_signal(topologyId, s)
          send_message('signal', Signal_args, :topologyId => topologyId, :s => s)
        end

        def recv_signal()
          result = receive_message(Signal_result)
          raise result.e unless result.e.nil?
          return
        end

      end

      class Processor
        include ::Thrift::Processor

        def process_setEnvironmentVar(seqid, iprot, oprot)
          args = read_args(iprot, SetEnvironmentVar_args)
          result = SetEnvironmentVar_result.new()
          begin
            @handler.setEnvironmentVar(args.name, args.value)
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'setEnvironmentVar', seqid)
        end

        def process_signal(seqid, iprot, oprot)
          args = read_args(iprot, Signal_args)
          result = Signal_result.new()
          begin
            @handler.signal(args.topologyId, args.s)
          rescue ::Concord::Thrift::BoltError => e
            result.e = e
          end
          write_result(result, oprot, 'signal', seqid)
        end

      end

      # HELPER FUNCTIONS AND STRUCTURES

      class SetEnvironmentVar_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        NAME = 1
        VALUE = 2

        FIELDS = {
          NAME => {:type => ::Thrift::Types::STRING, :name => 'name'},
          VALUE => {:type => ::Thrift::Types::STRING, :name => 'value'}
        }

        def struct_fields; FIELDS; end

        def validate
        end

        ::Thrift::Struct.generate_accessors self
      end

      class SetEnvironmentVar_result
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

      class Signal_args
        include ::Thrift::Struct, ::Thrift::Struct_Union
        TOPOLOGYID = 1
        S = 2

        FIELDS = {
          TOPOLOGYID => {:type => ::Thrift::Types::I64, :name => 'topologyId'},
          S => {:type => ::Thrift::Types::I32, :name => 's', :enum_class => ::Concord::Thrift::Signal}
        }

        def struct_fields; FIELDS; end

        def validate
          unless @s.nil? || ::Concord::Thrift::Signal::VALID_VALUES.include?(@s)
            raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field s!')
          end
        end

        ::Thrift::Struct.generate_accessors self
      end

      class Signal_result
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
