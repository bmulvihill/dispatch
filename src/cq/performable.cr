module Performable
  macro included
    extend Performable::ClassMethods
  end

  module ClassMethods
    def perform_async(*args)
      work = Cq::Job.new { self.new.perform(*args) }
      job_queue.push(work)
    end

    def job_queue
      Dispatcher.job_queue
    end
  end
end
