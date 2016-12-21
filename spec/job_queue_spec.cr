require "./spec_helper"

module Dispatch
  describe JobQueue do
    describe "#push" do
      it "will add work to the queue" do
        queue = JobQueue.new(1)
        queue.push(Job.new { })
        queue.full?.should eq(true)
      end
    end

    describe "#pop" do
      it "will remove work from the queue" do
        queue = JobQueue.new(1)
        queue.push(Job.new { })
        queue.pop
        queue.empty?.should eq(true)
      end
    end
  end
end
