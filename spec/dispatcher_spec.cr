require "./spec_helper"

module Cq
  describe Dispatcher do
    describe "#start and #stop" do
      it "can be started and stopped" do
        Dispatcher.start
        Dispatcher.running?.should eq(true)
        Dispatcher.stop
        Dispatcher.stopped?.should eq(true)
      end

      it "can be restarted"do
        Dispatcher.stop
        Dispatcher.running?.should eq(false)
        Dispatcher.start
        Dispatcher.running?.should eq(true)
      end
    end

    describe "#workers" do
      it "will have 5 workers by default" do
        Dispatcher.workers.size.should eq(5)
      end
    end

    describe "#job_queue" do
      it "will return a buffered job queue" do
        Dispatcher.job_queue.should be_a(JobQueue)
      end
    end
  end
end
