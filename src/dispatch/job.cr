# A Job wraps a unit of work
module Dispatch
  class Job
    def initialize(&work)
      @work = work
    end

    def perform
      @work.call
      true
    rescue ex
      Dispatch.process_exception(ex, self)
      false
    end
  end
end
