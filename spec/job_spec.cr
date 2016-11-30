require "./spec_helper"

module Cq
  describe Job do
    describe "#new" do
      it "takes a block in its constructor" do
        Job.new { 1 }
      end
    end

    describe "#perform" do
      it "will execute the job's work block" do
        x = 1
        job = Job.new { x += 1 }
        job.perform
        x.should eq 2
      end
    end
  end
end
