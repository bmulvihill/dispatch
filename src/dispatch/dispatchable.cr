# Provides a class with the ability to be dispatched
module Dispatchable
  macro included
    extend Dispatchable::ClassMethods
  end

  module ClassMethods
    def dispatch(*args)
      dispatcher.start unless dispatcher.running?
      work = Dispatch::Job.new { self.new.perform(*args) }
      dispatcher.dispatch(work)
    end

    def dispatch_in(interval, *args)
      dispatcher.start unless dispatcher.running?
      work = Dispatch::Job.new { self.new.perform(*args) }
      dispatcher.dispatch_in(interval, work)
    end

    def dispatcher
      Dispatch::Dispatcher
    end
  end
end
