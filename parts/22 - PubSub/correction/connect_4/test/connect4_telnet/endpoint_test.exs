defmodule Connect4Telnet.EndpointTest do
  use ExUnit.Case

  alias Connect4Telnet.Endpoint

  setup_all %{} do
    {:ok, _} = Connect4.Utils.PubSub.start_link([])
    {:ok, %{}}
  end

  test "starts the supervisor" do
    assert {:ok, pid} = Endpoint.start_link([])
    Supervisor.stop(pid, :normal, 5000)
  end

  test "initializes with correct children" do
    assert {:ok, pid} = Endpoint.start_link([])

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, _dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] = Supervisor.which_children(pid)

    Supervisor.stop(pid, :normal, 5000)
  end

  test "kill the server relaunches it" do
    assert {:ok, pid} = Endpoint.start_link([])

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, _dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] = Supervisor.which_children(pid)

    assert :ok = Supervisor.terminate_child(pid, Task)

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, _dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] =
             Supervisor.which_children(pid)

    Supervisor.stop(pid, :normal, 5000)
  end

  test "kill the task supervisor relaunches it" do
    assert {:ok, pid} = Endpoint.start_link([])

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, _dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] = Supervisor.which_children(pid)

    assert :ok = Supervisor.terminate_child(pid, Connect4Telnet.Endpoint.DynamicSupervisor)

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, _dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] =
             Supervisor.which_children(pid)

    Supervisor.stop(pid, :normal, 5000)
  end

  test "accepts connections" do
    port = Application.get_env(:servy, :port) || 4040

    assert {:ok, pid} = Endpoint.start_link([])

    assert [
             {Task, _task_pid, :worker, [Task]},
             {Connect4Telnet.Endpoint.DynamicSupervisor, dyn_sup_pid, :supervisor,
              [DynamicSupervisor]}
           ] = Supervisor.which_children(pid)

    # count the number of connections
    dyn_sup_children = DynamicSupervisor.which_children(dyn_sup_pid)
    assert length(dyn_sup_children) == 0

    assert {:ok, socket} =
             :gen_tcp.connect(~c"127.0.0.1", port, [:binary, packet: :line, active: false])

    # Wait for the server to accept the connection
    assert {:ok, _confirmation_msg} = :gen_tcp.recv(socket, 0, 5000)

    # count the number of connections
    dyn_sup_children = DynamicSupervisor.which_children(dyn_sup_pid)
    assert length(dyn_sup_children) == 1

    :ok = :gen_tcp.close(socket)

    Supervisor.stop(pid, :normal, 5000)
  end
end
