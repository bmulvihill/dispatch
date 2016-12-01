# Provides a class with the ability to be dispatched
module Dispatchable
  macro included
    extend Dispatchable::ClassMethods
  end

  module ClassMethods
    def perform_async(*args)
      Dispatch::Dispatcher.start unless Dispatch::Dispatcher.running?
      work = Dispatch::Job.new { self.new.perform(*args) }
      Dispatch::Dispatcher.dispatch(work)
    end

    def perform_in(interval, *args)
      Dispatch::Dispatcher.start unless Dispatch::Dispatcher.running?
      work = Dispatch::Job.new { self.new.perform(*args) }
      Dispatch::Dispatcher.dispatch_in(interval, work)
    end

    def perform_now(*args)
      work = Dispatch::Job.new { self.new.perform(*args) }
      work.perform
    end
  end
end
