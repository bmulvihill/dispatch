module Cq
  module Performable
    macro included
      extend Cq::Performable::ClassMethods
    end

    module ClassMethods
      def perform_async(*args)
        Dispatcher.start unless Dispatcher.running?
        work = Cq::Job.new { self.new.perform(*args) }
        job_queue.push(work)
      end

      def job_queue
        Dispatcher.job_queue
      end
    end
  end
end
