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

      it "will return false if a job fails" do
        String.build do |io|
          logger = Logger.new(io)
          Dispatch.logger = logger
          job = Job.new { raise "Error!" }
          job.perform.should eq(false)
        end
      end
    end
  end
end
