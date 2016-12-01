# A Dispatcher is responsible for pulling work off the job queue
# It assigns the work to the next available worker
module Dispatch
  class Dispatcher
    def self.config
      # placeholder for class config
    end

    def self.start
      INSTANCE.start
    end

    def self.stop
      INSTANCE.stop
    end

    def self.stopped?
      INSTANCE.stopped?
    end

    def self.running?
      INSTANCE.running?
    end

    def self.workers
      INSTANCE.workers
    end

    def self.dispatch(work)
      INSTANCE.job_queue.push(work)
    end

    def self.dispatch_in(interval, work)
      spawn do
        sleep interval
        INSTANCE.job_queue.push(work)
      end
    end

    getter job_queue
    getter workers

    private def initialize(num_workers = 5, queue_size = 100)
      @job_queue = Dispatch::JobQueue.new(queue_size)
      @dispatch_queue = Channel(JobQueue).new(num_workers)
      @workers = Array(Worker).new(num_workers)
      @num_workers = num_workers
    end

    def start
      return false if running?
      create_workers
      workers.each &.start

      spawn do
        while running?
          work = job_queue.pop
          worker = dispatch_queue.receive
          worker.push(work)
        end
      end
    end

    def stopped?
      workers.all? &.stopped?
    end

    def running?
      !stopped?
    end

    def stop
      workers.each &.stop
    end

    private INSTANCE = new
    private getter dispatch_queue
    private getter num_workers

    private def create_workers
      if !dispatch_queue.full?
        num_workers.times do |i|
          worker = Worker.new(dispatch_queue)
          workers << worker
        end
      end
    end
  end
end
