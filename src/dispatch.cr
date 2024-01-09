require "./dispatch/*"
require "log"

module Dispatch
  NAME    = "Dispatch"
  VERSION = "0.2.0"

  def self.config
    @@config ||= Configuration.new
  end

  def self.configure
    yield(config)
  end

  def self.process_exception(ex, klass)
    logger.error do
      String.build do |io|
        io << "Dispatch error:\n"
        io << "#{ex.class} #{ex}\n"
        io << ex.backtrace.join("\n") if ex.backtrace
      end
    end
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
