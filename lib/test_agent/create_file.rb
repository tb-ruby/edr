require_relative "base_action"

module TestAgent
  class CreateFile < BaseAction
    def self.call(path)
      File.write(path, ":-) " * 50)

      timestamp = Time.now.to_i
      pid = Process.pid

      log = {type: "create_file",
             timestamp: timestamp,
             path: path,
             process_name: process_name(pid),
             command: command(pid),
             username: username,
             process_id: pid}

      LogWriter.instance.write(log)
    end
  end
end
