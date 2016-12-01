module Dispatch
  class Worker
    getter id : String

    def initialize(dispatch_queue)
      @dispatch_queue = dispatch_queue
      @job_queue = JobQueue.new
      dispatch_queue.send(job_queue)

      @stopped = true
      @id = ""
    end

    def start
      return if running?
      @stopped = false

      spawn do
        @id = Fiber.current.object_id.to_s(36)
        while (work = job_queue.pop) && !stopped?
          work.perform
          dispatch_queue.send(job_queue)
        end
      end
      true
    end

    def stop
      @stopped = true
    end

    def stopped?
      @stopped
    end

    def running?
      !@stopped
    end

    private getter job_queue : JobQueue
    private getter dispatch_queue : Channel(JobQueue)
  end
end
