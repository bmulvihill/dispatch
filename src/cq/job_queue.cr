# A job queue hold Cq::Jobs which are waitng to be executed
module Cq
  class JobQueue
    getter queue

    def initialize(size = nil)
      if size
        @queue = Channel(Cq::Job).new(size) # buffered job queue
      else
        @queue = Channel(Cq::Job).new # unbuffered job queue
      end
    end

    def push(job)
      queue.send(job)
    end

    def pop
      queue.receive
    end
  end
end
