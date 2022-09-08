require_relative "base_action"
require "socket"

module TestAgent
  class NetworkConnection < BaseAction
    def self.call(host, port)
      socket = TCPSocket.new host, port.to_i

      remote_host, remote_port = socket.remote_address.ip_unpack
      local_host, local_port = socket.local_address.ip_unpack

      data = socket.write "!!!" * rand(1..10)
      socket.close

      timestamp = Time.now.to_i
      pid = Process.pid

      log = {type: "network_connection",
             timestamp: timestamp,
             destination_address: remote_host,
             destination_port: remote_port,
             source_address: local_host,
             source_port: local_port,
             protocol: "TCP",
             data_sent: data,
             process_name: process_name(pid),
             command: command(pid),
             username: username,
             process_id: pid}

      LogWriter.instance.write(log)
    end
  end
end
