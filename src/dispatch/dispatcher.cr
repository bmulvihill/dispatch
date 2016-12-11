# A Dispatcher is responsible for pulling work off the job queue
# It assigns the work to the next available worker
module Dispatch
  class Dispatcher

    def self.instance
      @@instance ||= new(config)
    end

    def self.config
      @@config ||= Configuration.new
    end

    def self.configure
      yield(config)
    end

    def self.start
      instance.start
    end

    def self.stop
      instance.stop
    end

    def self.stopped?
      instance.stopped?
    end

    def self.running?
      instance.running?
    end

    def self.workers
      instance.workers
    end

    def self.dispatch(work)
      instance.job_queue.push(work)
    end

    def self.dispatch_in(interval, work)
      spawn do
        sleep interval
        instance.job_queue.push(work)
      end
    end

    getter job_queue
    getter workers

    private def initialize(config : Configuration)
      @job_queue = Dispatch::JobQueue.new(config.queue_size)
      @dispatch_queue = Channel(JobQueue).new(config.num_workers)
      @workers = Array(Worker).new(config.num_workers)
      @config = config
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

    private getter config
    private getter dispatch_queue

    private def create_workers
      if !dispatch_queue.full?
        config.num_workers.times do |i|
          worker = Worker.new(dispatch_queue)
          workers << worker
        end
      end
    end
  end
end
