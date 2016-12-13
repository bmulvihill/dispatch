require "./src/Dispatch"

# Simple example

Dispatch.configure do |config|
  config.num_workers = 5
  config.queue_size = 10
end

class FakeJob
  include Dispatchable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

Dispatch.config # => <Dispatch::Configuration:0x1042dafb0 @num_workers=5, @queue_size=10>
FakeJob.dispatch("Bob")
FakeJob.dispatch("Emily")
FakeJob.dispatch_in(5.seconds, "Billy")
FakeJob.dispatch("Maddy")
Dispatch::SuccessCounter.value # => 0

sleep 6

Dispatch::SuccessCounter.value # => 4
