require "./cq/job"
require "./cq/worker"
require "./cq/performable"
require "./cq/dispatcher"
require "./cq/job_queue"

module Cq
  NAME    = "CQ"
  VERSION = "0.1.0"
end

# Simple example
# d = Cq::Dispatcher.start(2)
#
# FakeJob.perform_async("Bob")
# FakeJob.perform_async("Emily")
# FakeJob.perform_async("Maddy")
# FakeJob.perform_async("James")
# FakeJob.perform_async("James")
# FakeJob.perform_async("James")
#
# #sleep 10
# loop do
#   input = gets
#   FakeJob.perform_async("#{input}")
# end
