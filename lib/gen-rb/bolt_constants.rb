#
# Autogenerated by Thrift Compiler (0.9.2)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'bolt_types'

module Concord
  module Thrift
    KBoltEnvKeyBasePath = %q"BOLT_BASE_PATH"

    KBoltDefaultEnvBasePath = %q"/tmp/"

    KBoltEnvKeyPathPrefix = %q"BOLT"

    KDefaultThriftServiceIOThreads = 2

    KConcordEnvKeyClientListenAddr = %q"CONCORD_client_listen_address"

    KConcordEnvKeyClientProxyAddr = %q"CONCORD_client_proxy_address"

    KDatabasePath = %q"/tmp"

    KDatabaseEntryTTL = 43200

    KDefaultBatchSize = 2048

    KDefaultTraceSampleEveryN = 1024

    KPrincipalComputationName = %q"principal_computation"

    KIncomingMessageQueueTopic = %q"incoming"

    KPrincipalTimerQueueTopic = %q"principal_timers"

    KOutgoingMessageQueueTopic = %q"outgoing"

    KQueueStreamNameToIdMapTopic = %q"stream_map"

    KMessageQueueWatermarkTopic = %q"watermarks"

    KMessageQueueBatchSize = 1024

    KMessageQueueTTL = 21600

  end
end
