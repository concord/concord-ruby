# Some helper functions useful in client computations
module Concord::Utils
  extend self

  # Get the time in milliseconds
  # @param t [Time] The time to convert to milliseconds
  def time_millis(t = Time.now)
    (t.to_f * 1000.0).to_i
  end

  # Log message to stderr
  # @param str [String] The message to print to stderr
  def log_to_stderr(str)
    $stderr.puts str
    $stderr.flush
  end
end
