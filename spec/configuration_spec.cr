require "./spec_helper"

module Dispatch
  describe Configuration do
    Spec.after_each do
      Dispatcher.configure do |config|
        config.num_workers = 5
        config.queue_size = 100
      end
    end

    describe "#configure" do
      it "will set the default values" do
        Dispatch::Dispatcher.config.num_workers.should eq(5)
        Dispatch::Dispatcher.config.queue_size.should eq(100)
      end

      it "will allow the setting of configurable values" do
        Dispatcher.configure do |config|
          config.num_workers = 1234
          config.queue_size = 4321
        end

        Dispatch::Dispatcher.config.num_workers.should eq(1234)
        Dispatch::Dispatcher.config.queue_size.should eq(4321)
      end
    end
  end
end
