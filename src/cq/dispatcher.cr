# A Dispatcher is responsible for pulling work off the job queue
# It assigns the work to the next available worker
module Cq
  class Dispatcher
    INSTANCE = new

    getter job_queue
    getter worker_queue

    def self.instance
      INSTANCE
    end

    def self.start(num_workers)
      instance.start(num_workers)
    end

    private def initialize
      @job_queue = Cq::JobQueue.new(100)
      @worker_queue = uninitialized Channel(JobQueue)
    end

    def start(num_workers)
      @worker_queue = Channel(JobQueue).new(num_workers)

      num_workers.times do |i|
        worker = Worker.new
        worker.start(worker_queue)
      end

      spawn do
        loop do
          work = job_queue.pop
          worker = worker_queue.receive
          worker.push(work)
        end
      end
    end
  end
end
