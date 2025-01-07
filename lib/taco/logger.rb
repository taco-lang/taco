require "logger"

module Taco
  class TacoLogger
    def self.create_logger
      logger = ::Logger.new(STDOUT)
      logger.level = ::Logger::INFO
      logger.formatter = proc do |severity, datetime, _progname, msg|
        "#{datetime} [#{severity}] #{msg}\n"
      end

      logger
    end
  end
end
