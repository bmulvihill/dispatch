require "./src/Dispatch"

# Simple example
class FakeJob
  include Dispatchable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

FakeJob.dispatch("Bob")
FakeJob.dispatch("Emily")
FakeJob.dispatch_in(5.seconds, "Billy")
FakeJob.dispatch("Maddy")

sleep 10
