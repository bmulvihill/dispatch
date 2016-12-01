require "./src/Dispatch"

# Simple example
class FakeJob
  include Dispatchable

  def perform(name)
    p "#{Time.now}: Hello, #{name}"
  end
end

FakeJob.perform_async("Bob")
FakeJob.perform_async("Emily")
FakeJob.perform_now("James")
FakeJob.perform_in(5.seconds, "Billy")
FakeJob.perform_async("Maddy")

sleep 10
