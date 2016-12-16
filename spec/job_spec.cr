require "./spec_helper"

module Dispatch
  describe Job do
    describe "#perform" do
      it "will execute the job's work block" do
        x = 1
        job = Job.new { x += 1 }
        job.perform
        x.should eq 2
      end

      it "updates the success counter" do
        Dispatch::SuccessCounter.reset
        job = Job.new { }
        job.perform
        Dispatch::SuccessCounter.value.should eq(1)
      end

      it "calls writes to the logger if a job fails" do
        result = String.build do |io|
          logger = Logger.new(io)
          Dispatch.configure { |c| c.logger = logger }
          job = Job.new { raise "Error!" }
          job.perform
        end
        result.should_not eq("")
        Dispatch::FailureCounter.value.should eq(1)
      end
    end
  end
end
