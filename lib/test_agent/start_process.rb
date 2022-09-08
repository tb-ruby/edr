require_relative "base_action"

module TestAgent
  class StartProcess < BaseAction
    def self.call(path, arguments)
      timestamp = Time.now.to_i
      pid = spawn(path, arguments)
      Process.detach pid

      log = {type: "start_process",
             timestamp: timestamp,
             process_name: process_name(pid),
             command: command(pid),
             username: username,
             process_id: pid}

      LogWriter.instance.write(log)
    end
  end
end
