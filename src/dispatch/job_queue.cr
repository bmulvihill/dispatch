class Channel::Buffered
  def pop
    receive
  end

  def push(value)
    send(value)
  end

  def size
    @queue.size
  end
end

class Channel::Unbuffered
  def pop
    receive
  end

  def push(value)
    send(value)
  end
end

# A job queue holds Dispatch::Jobs waiting to be executed
module Dispatch
  alias JobQueue = Channel(Dispatch::Job)
end
