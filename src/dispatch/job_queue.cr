# A job queue holds Dispatch::Jobs waiting to be performed
module Dispatch
  class JobQueue
    def initialize(size = nil)
      if size
        @queue = Channel(Dispatch::Job).new(size)
      else
        @queue = Channel(Dispatch::Job).new
      end
    end

    def push(job)
      queue.send(job)
    end

    def pop
      queue.receive
    end

    private getter queue

    delegate full?, to: queue
    delegate empty?, to: queue
  end
end
