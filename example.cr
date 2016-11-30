require "./src/cq"

# Simple example
class FakeJob
  include Cq::Performable

  def perform(name)
    p "Hello, #{name}"
  end
end

FakeJob.perform_async("Bob")
FakeJob.perform_async("Emily")
FakeJob.perform_async("Maddy")
FakeJob.perform_async("James")
FakeJob.perform_async("James")
FakeJob.perform_async("James")

# sleep 10
loop do
  input = gets
  FakeJob.perform_async("#{input}")
end
