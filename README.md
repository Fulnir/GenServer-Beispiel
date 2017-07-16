# GenTest

Ein paar Zeilen Code und fertig ist ein "GenServer" Beispiel.


## GenServer

Das Modul GenServer liefert die Funktionen eines generischen Servers.


Zuerst ein Module erzeugen

```
defmodule ShoppingList do
  use GenServer
end
```

### Den Serverprozess starten
Die erste Funktion, die implementiert wird, ist für den Start des Servers.

Die Funktion ```start_link()``` wird im GenServer-Modul drei Argumenten aufrufen.

Das erste Argument ist das Modul in dem Server-Callbacks implementiert sind. 

Das nächste Argument ist ein Initialisierungsargument für das Modul. Da in diesem Beispiel kein Argument erforderlich ist, wird das :ok Atom übergeben.

Und schließlich ist das dritte Argument eine Liste von Optionen. In diesem Fall eine leere Liste.

```
def start_link do
  GenServer.start_link(__MODULE__, :ok, [])
end
```

### Anrufen und Casting von der öffentlichen API
Als nächstes müssen wir die öffentliche API für das Modul zur Verfügung stellen. Dies sind die Funktionen, die von anderen Modulen Ihrer Anwendung aufgerufen werden.

Die read/1-Funktion ruft die Call/2-Funktion des GenServer.module auf, um die Anfrage an den Prozess zu senden. Der Prozess blockiert, bis er eine Antwort vom Server erhalten hat. Das erste Argument ist die ProzessID. Das zweite der Term der für die Auswahl (Per Pattern-Mattiching) des Callback-Handle benötigt wird.

Die add/2-Funktion ruft die Cast/2-Funktion des GenServer.module auf. Diese Funktion wartet nicht auf die Antwort des Servers.
```
def read(pid) do
  GenServer.call(pid, {:read})
end
 
def add(pid, item) do
  GenServer.cast(pid, {:add, item})
end
```

### Initialisierung des Servers

```
def init(:ok) do
  {:ok, []}
end
```

#### Handling Call requests
Next we need to handle the incoming requests from the public API. First we will handle the :read request:

```
def handle_call({:read}, _from, list) do
  {:reply, list, list}
end
```
#### Handling Cast requests
Next we can handle the cast request:

```
def handle_cast({:add, item}, list) do
  {:noreply, list ++ [item]}
end
```

Die Datei ```todo_list.ex``` sieht dann folgendermaßen aus.

```
defmodule TodoList do
  use GenServer
 
  # Client API
 
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end
 
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
```
### Iex
Jetzt im Terminal ```iex todo_list.ex``` aufrufen.

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
Und bekommen ```["Learn Elixir", "Build a great app"]```



