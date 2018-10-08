require "./src/dispatch"

# Simple example
Dispatch.configure do |config|
  config.num_workers = 5
  config.queue_size = 10
  config.logger = Logger.new(IO::Memory.new)
end

class FakeJob
  include Dispatchable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

class ErrorJob
  include Dispatchable

  def perform
    raise "Hello!"
  end
end

Dispatch.config # => <Dispatch::Configuration:0x1042dafb0 @num_workers=5, @queue_size=10>
FakeJob.dispatch("Bob")
FakeJob.dispatch("Emily")
FakeJob.dispatch_in(5.seconds, "Billy")
FakeJob.dispatch("Maddy")
ErrorJob.dispatch
Dispatch.successes # => 0
sleep 6

Dispatch.successes # => 4
Dispatch.failures  # => 1
