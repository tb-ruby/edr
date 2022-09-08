require "singleton"
require "json"
module TestAgent
  class LogWriter
    include Singleton

    def initialize
      @file = File.open("log/agent.log", "a")
    end

    def write(message)
      @file.puts JSON.generate(message)
    end
  end
end
