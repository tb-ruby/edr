require_relative "base_action"

module TestAgent
  class DeleteFile < BaseAction
    def self.call(path)
      File.delete(path)

      timestamp = Time.now.to_i
      pid = Process.pid

      log = {type: "delete_file",
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
