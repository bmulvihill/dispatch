module Cq
  class Job
    def initialize(&work)
      @work = work
    end

    def perform
      @work.call
    end
  end
end
