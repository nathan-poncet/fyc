defmodule Connect4Telnet.Conn do
  defstruct params: [],
            path: [],
            pid: nil,
            response: "",
            request: "",
            socket: nil,
            status: :ok
end
