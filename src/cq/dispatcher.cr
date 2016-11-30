# A Dispatcher is responsible for pulling work off the job queue
# It assigns the work to the next available worker
module Cq
  class Dispatcher
    INSTANCE = new

    # placehold for class config
    def self.config
      nil
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

    def self.job_queue
      INSTANCE.job_queue
    end

    getter job_queue
    getter workers

    private def initialize(num_workers = 5)
      @job_queue = Cq::JobQueue.new(100)
      @worker_queue = Channel(JobQueue).new(num_workers)
      @workers = Array(Worker).new(num_workers)
      @num_workers = num_workers
      @stopped = true
      create_workers
    end

    def start
      @stopped = false
      workers.each &.start

      spawn do
        work = job_queue.pop
        worker = worker_queue.receive
        worker.push(work)
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

    private getter worker_queue
    private getter num_workers

    private def create_workers
      if !worker_queue.full?
        num_workers.times do |i|
          worker = Worker.new(worker_queue)
          workers << worker
        end
      end
    end

  end
end
