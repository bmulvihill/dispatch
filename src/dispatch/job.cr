# A Job wraps a unit of work
module Dispatch
  class Job
    def initialize(&work)
      @work = work
    end

    def perform
      @work.call
      Dispatch::SuccessCounter.increment
    rescue ex
      Dispatch::FailureCounter.increment
      Dispatch.process_exception(ex, self)
    end
  end
end
