require 'concord'
require 'concord/utils'

class WordCountSource
  def init(ctx)
    ctx.set_timer('loop', Concord::Utils.time_millis)
  end

  def process_timer(ctx, key, time)
    ctx.produce_record("test", "test-key", "test-value")
    ctx.set_timer(key, Concord::Utils.time_millis + 5000)
  end

  def metadata
    Concord::Metadata.new(name: 'test-src', ostreams: ['test'])
  end
end

Concord::Computation.serve(WordCountSource.new)
