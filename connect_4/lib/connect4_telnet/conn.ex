defmodule Connect4Telnet.Conn do
  defstruct listen_pid: nil,
            params: [],
            path: [:game],
            resp: "",
            socket: nil,
            status: :ok
end
