defmodule ToDoList do
  @moduledoc """

  Im Terminal ```iex todo_list.ex``` aufrufen.

  Den Server starten
  ```
  iex> {:ok, pid} = ToDoList.start_link 
  ```
  Der Server antwortet mit ```{:ok, #PID<0.88.0>```
  Jetzt kann die erste Aufgabe hinzugefügt werden.

  ```
  iex(2)> ToDoList.add(pid, "Learn Elixir")
  # Und eine zweite
  iex(3)> ToDoList.add(pid, "Build a great app")
  ```

  Nun lesen wir die Liste aus
  ```
  iex(4)> TodoList.read(pid)
  ```
  Und bekommen ```["Learn Elixir", "Build a great app"```
  """
  use GenServer
 
  # Client API

  @doc """
  Start des Servers
  """
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end
 
  @doc """
  
  """
  def read(pid) do
    GenServer.call(pid, {:read})
  end
 
  def add(pid, item) do
    GenServer.cast(pid, {:add, item})
  end
 
  # Server Callbacks
 
  def init(:ok) do
    {:ok, []}
  end
 
  def handle_call({:read}, from, list) do
    {:reply, list, list}
  end
 
  def handle_cast({:add, item}, list) do
    {:noreply, list ++ [item]}
  end
end