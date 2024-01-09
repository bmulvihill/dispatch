require "./spec_helper"

class FakeJob
  include Dispatchable

  def perform(*args)
    args[0].value += 1
  end
end

describe Dispatchable do
  describe "#dispatch" do
    it "will execute a job asynchrously" do
      x = 1
      ptr_x = pointerof(x)
      FakeJob.dispatch(ptr_x)
      ptr_x.value.should eq(1)
      sleep 1
      ptr_x.value.should eq(2)
    end
  end

  describe "#dispatch_in" do
    it "will perform a job after a given interval" do
      x = 1
      ptr_x = pointerof(x)
      FakeJob.dispatch_in(1.seconds, ptr_x)
      ptr_x.value.should eq(1)
      sleep 0.5
      ptr_x.value.should eq(1)
      sleep 1
      ptr_x.value.should eq(2)
    end
  end
end
