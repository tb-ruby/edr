require_relative "base_action"

module TestAgent
  class ModifyFile < BaseAction
    def self.call(path)
      File.open(path, "a") do |f|
        f.puts "!!!" * 5
      end

      timestamp = Time.now.to_i
      pid = Process.pid

      log = {type: "modify_file",
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
