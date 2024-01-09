module Dispatch
  class Configuration
    property num_workers : Int32
    property queue_size : Int32
    property logger : ::Log

    def initialize
      @num_workers = 5
      @queue_size = 100
      @logger = ::Log.for("dispatch")
    end
  end
end
