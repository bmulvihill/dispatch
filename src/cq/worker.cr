module Cq
  class Worker
    getter jobs
    getter id : String

    def initialize
      @jobs = JobQueue.new # channel for jobs this worker will be assigned
      @id = ""
    end

    def start(worker_queue)
      worker_queue.send(jobs)# Add jobs channel to worker queue so dispatcher can assign

      spawn do
        @id = Fiber.current.object_id.to_s(36)
        until stopped?
          work = jobs.pop
          work.perform
          worker_queue.send(jobs) # notify dispatcher worker is available again
        end
      end
    end

    private def stopped?
      false
    end
  end
end
