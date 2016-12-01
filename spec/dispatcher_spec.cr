require "./spec_helper"

module Dispatch
  describe Dispatcher do
    describe "#start and #stop" do
      it "can be started and stopped" do
        Dispatcher.start
        Dispatcher.running?.should eq(true)
        Dispatcher.stop
        Dispatcher.stopped?.should eq(true)
      end

      it "can be restarted" do
        Dispatcher.stop
        Dispatcher.running?.should eq(false)
        Dispatcher.start
        Dispatcher.running?.should eq(true)
      end

      it "will not start twice" do
        Dispatcher.start.should eq(false)
      end
    end

    describe "#workers" do
      it "will have 5 workers by default" do
        Dispatcher.workers.size.should eq(5)
      end
    end

    describe "#dispatch" do
      it "will dispatch a unit of work" do
        x = 1
        work = Job.new { x += 1 }
        Dispatcher.dispatch(work)
        sleep 1
        x.should eq(2)
      end
    end
  end
end
