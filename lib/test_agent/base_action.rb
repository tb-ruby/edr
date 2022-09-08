require "ps-ruby"
require_relative "log_writer"

module TestAgent
  class BaseAction
    def self.username
      Etc.getpwuid(Process.uid).name
    end

    def self.command(pid)
      @command ||= begin
        processes = PS.get_all_processes.find_processes_by("PID", pid.to_s)
        processes&.first&.dig "COMMAND"
      end
    end

    def self.process_name(pid)
      command(pid).split(" ")&.first&.split("/")&.last&.gsub(/[()]/, "")
    end
  end
end
