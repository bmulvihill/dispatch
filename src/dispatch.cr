require "./dispatch/configuration"
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

  def self.config
    @@config ||= Configuration.new
  end

  def self.configure
    yield(config)
  end

  def self.process_exception(ex, klass)
    error_msg = String.build do |io|
      io << "Dispatch error:\n"
      io << "#{ex.class} #{ex}\n"
      io << ex.backtrace.join("\n") if ex.backtrace
    end
    logger.error(error_msg)
  end

  def self.logger
    config.logger
  end

  def self.successes
    Dispatch::SuccessCounter.value
  end

  def self.failures
    Dispatch::FailureCounter.value
  end
end
