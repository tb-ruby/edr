require_relative "create_file"
require_relative "modify_file"
require_relative "start_process"
require_relative "delete_file"

module TestAgent
  class CLI < Thor
    include Thor::Actions

    def self.exit_on_failure?
      true
    end

    desc "start_process", "Start a process, given a path to an executable file and the desired (optional) command-line arguments"
    def start_process
      path = options[:path]
      arguments = options[:arguments]

      TestAgent::StartProcess.call(path, arguments)
    end
    method_option :path, type: :string, for: :start_process, required: true, desc: "The path to the executable file to start"
    method_option :arguments, default: "", type: :string, for: :start_process, required: false, desc: "The command-line arguments"

    desc "make_file", "Create a file of a specified type at a specified location"
    def make_file
      path = options[:path]

      TestAgent::CreateFile.call(path)
    end
    method_option :path, type: :string, for: :make_file, required: true

    desc "modify_file", "Modify a file given its path"

    def modify_file
      path = options[:path]

      TestAgent::ModifyFile.call(path)
    end
    method_option :path, type: :string, for: :modify_file, required: true, desc: "The file to be modified"

    desc "delete_file", "Delete a file given its path"

    def delete_file
      path = options[:path]

      TestAgent::DeleteFile.call(path)
    end

    method_option :path, type: :string, for: :delete_file, required: true, desc: "The file to be removed"

    desc "network_connection", "create a network connection to a to a host / port, and transmit some data"

    def network_connection
      host = options[:host]
      port = options[:port]

      TestAgent::NetworkConnection.call(host, port)
    end

    method_option :host, type: :string, for: :network_connection, required: false, desc: "The host to connect to"
    method_option :port, type: :string, for: :network_connection, required: false, desc: "The port to connect to"
  end
end
