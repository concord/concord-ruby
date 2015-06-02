module Concord
  # Some helper functions useful in client computations
  module Utils
    extend self

    # Get the time in milliseconds
    # @param t [Time] The time to convert to milliseconds
    def time_millis(t = Time.now)
      (t.to_f * 1000.0).to_i
    end
  end
end

