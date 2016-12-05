module Dispatch
  class Worker
    def initialize(dispatch_queue)
      @dispatch_queue = dispatch_queue
      @job_queue = JobQueue.new
      @stopped = true
      dispatch_queue.send(job_queue)
    end

    def start
      return if running?
      @stopped = false

      spawn do
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
