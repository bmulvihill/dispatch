module Dispatch
  class Configuration
    property num_workers : Int32
    property queue_size : Int32

    def initialize
      @num_workers = 5
      @queue_size = 100
    end
  end
end
