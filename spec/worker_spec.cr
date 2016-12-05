require "./spec_helper"

module Dispatch
  describe Worker do
    describe "#start" do
      it "starts" do
        w = Worker.new(Channel(JobQueue).new(1))
        w.start.should eq(true)
      end

      it "will perform work" do
        dispatch_queue = Channel(JobQueue).new(1)
        w = Worker.new(dispatch_queue).start
        job_queue = dispatch_queue.receive
        x = 1
        job_queue.push(Job.new { x += 1 })
        sleep 1
        x.should eq(2)
      end
    end

    describe "#stop" do
      it "stops" do
        w = Worker.new(Channel(JobQueue).new(1))
        w.start
        w.stopped?.should eq false
        w.stop
        w.stopped?.should eq true
      end

      it "wont start new work" do
        dispatch_queue = Channel(JobQueue).new(1)
        w = Worker.new(dispatch_queue)
        w.start
        job_queue = dispatch_queue.receive
        x = 1
        job = Job.new { x += 1 }
        job_queue.push(job)
        x.should eq(2)
        sleep 1
        w.stop
        job_queue.push(job)
        sleep 1
        x.should eq(2)
      end
    end
  end
end
