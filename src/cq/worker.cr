module Cq
  class Worker
    getter id : String

    def initialize(worker_queue)
      @worker_queue = worker_queue
      @job_queue = JobQueue.new    # queue for jobs this worker will be assigned
      worker_queue.send(job_queue) # Add jobs channel to worker queue so dispatcher can assign

      @stopped = true
      @id = ""
    end

    def start
      @stopped = false

      spawn do
        @id = Fiber.current.object_id.to_s(36)
        while (work = job_queue.pop) && !stopped?
          work.perform
          worker_queue.send(job_queue)
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
    private getter worker_queue : Channel(JobQueue)
  end
end
