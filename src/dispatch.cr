require "./dispatch/job"
require "./dispatch/worker"
require "./dispatch/dispatchable"
require "./dispatch/dispatcher"
require "./dispatch/job_queue"
require "./dispatch/counter"
require "logger"

module Dispatch
  NAME    = "Dispatch"
  VERSION = "0.1.0"

  @@logger = Logger.new(STDOUT)

  def self.process_exception(ex, klass)
    error_msg = String.build do |io|
      io << "Dispatch error:\n"
      io << "#{ex.class} #{ex}\n"
      io << ex.backtrace.nil? ? "" : ex.backtrace.join("\n")
    end
    logger.error error_msg
  end

  def self.logger=(logger)
    @@logger = logger
  end

  def self.logger
    @@logger
  end
end
