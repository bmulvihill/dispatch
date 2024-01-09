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
        Log.capture do |logs|
          job = Job.new { raise "Error!" }
          job.perform

          logs.check(:error, /Dispatch error/)
        end
        Dispatch::FailureCounter.value.should eq(1)
      end
    end
  end
end
