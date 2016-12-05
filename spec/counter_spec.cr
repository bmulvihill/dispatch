require "./spec_helper"

module Dispatch
  describe SuccessCounter do
    describe "#reset" do
      it "resets the counter to 0" do
        SuccessCounter.increment
        SuccessCounter.reset.should eq(0)
      end
    end

    describe "#increment" do
      it "increments the counter value by 1" do
        SuccessCounter.reset
        SuccessCounter.increment.should eq(1)
      end
    end

    describe "#decrement" do
      it "decrements the counter value by 1" do
        SuccessCounter.reset
        SuccessCounter.increment
        SuccessCounter.increment
        SuccessCounter.decrement.should eq(1)
      end
    end
  end
end
