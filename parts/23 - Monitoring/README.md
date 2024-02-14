## 23 Monitoring

### 23.1 Cours

#### 23.1.1 Monitoring de Processus

Le monitoring de processus permet à un processus (observateur) de suivre l'existence d'un autre processus (observé). Lorsque le processus observé s'arrête, l'observateur reçoit un message {:DOWN, ref, :process, pid, reason} où ref est une référence au monitor, pid est l'identifiant du processus observé, et reason est la raison de l'arrêt.

Utilisation avec GenServer
Vous pouvez démarrer un monitor sur un processus (par exemple, un GenServer) en utilisant Process.monitor(pid). C'est utile dans des scénarios où un GenServer doit savoir si un autre processus (peut-être un autre GenServer sur lequel il dépend) s'arrête, pour prendre des mesures correctives ou nettoyer les ressources.

```elixir
defmodule MyGenServer do
  use GenServer

  # Fonction pour démarrer le GenServer
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Fonction d'initialisation
  def init(:ok) do
    # Démarrage d'un processus externe
    pid = spawn(fn -> perform_task() end)
    # Création d'un lien unidirectionel entre le GenServer et le processus externe
    Process.monitor(pid)

    {:ok, %{}}
  end

  def handle_info({:DOWN, _ref, :process, _pid, _reason}, state) do
    # Logique pour gérer l'arrêt du processus observé
    {:noreply, state}
  end
end
```

Dans cet exemple, MyGenServer monitorerait un autre processus. Lorsque le processus observé s'arrête, handle_info/2 dans MyGenServer capturerait le message :DOWN et pourrait exécuter une logique spécifique, comme démarrer un nouveau processus ou ajuster son état interne.

#### 23.1.2 Linking de Processus

Le linking crée une connexion bidirectionnelle entre deux processus, de sorte que si l'un s'arrête (normalement ou en raison d'une erreur), l'autre s'arrête également, à moins qu'il ne capture explicitement la sortie. Le linking est souvent utilisé pour coupler la vie de deux processus qui dépendent l'un de l'autre de manière critique.

Utilisation avec GenServer
Supposons que vous ayez un GenServer qui démarre un processus externe pour effectuer une tâche en arrière-plan. Vous pourriez vouloir lier ce processus au GenServer pour vous assurer que si le processus de tâche s'arrête de manière inattendue, cela entraîne également l'arrêt du GenServer, ce qui peut aider à maintenir un état cohérent dans votre système.

```elixir
defmodule MyGenServer do
  use GenServer

  # Fonction pour démarrer le GenServer
  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Fonction d'initialisation
  def init(:ok) do
    # Démarrage d'un processus externe
    pid = spawn(fn -> perform_task() end)
    # Création d'un lien entre le GenServer et le processus externe
    Process.link(pid)

    {:ok, %{}}
  end
end
```

Dans cet exemple, Process.link(pid) crée un lien entre le GenServer (processus appelant Process.link) et le processus créé par spawn(fn -> perform_task() end). Si le processus de tâche se termine, le GenServer recevra une notification de sortie et s'arrêtera également, sauf s'il gère explicitement les sorties avec Process.flag(:trap_exit, true).

Gestion des Sorties avec Trap Exit
Pour gérer les sorties et éviter que le GenServer ne s'arrête lorsqu'un processus lié se termine, vous pouvez activer le piège de sortie (trap_exit). Cela permet au GenServer de recevoir un message de sortie qu'il peut gérer dans handle_info/2.

```elixir
defmodule MyGenServer do
  use GenServer

  def init(:ok) do
    # Activation du piège de sortie
    Process.flag(:trap_exit, true)

    pid = spawn(fn -> perform_task() end)
    Process.link(pid)

    {:ok, %{}}
  end

  def handle_info({:EXIT, _pid, reason}, state) do
    # Gestion de la sortie du processus lié
    IO.puts("Process exited with reason: #{inspect(reason)}")
    {:noreply, state}
  end
end
```

Avec Process.flag(:trap_exit, true), lorsque le processus lié s'arrête, le GenServer reçoit un message {:EXIT, pid, reason} au lieu de s'arrêter. Cela permet au GenServer de gérer l'arrêt du processus lié de manière appropriée, par exemple en redémarrant le processus ou en prenant d'autres mesures correctives.

#### 23.1.3 Comparaison entre Monitoring et Linking

Direction: Le monitoring est unidirectionnel (l'observateur surveille l'observé), tandis que le linking est bidirectionnel (les deux processus sont connectés).

Impact sur le Processus: Avec le monitoring, l'arrêt d'un processus n'affecte pas directement l'observateur, qui reçoit simplement un message :DOWN. Avec le linking, si l'un des processus liés s'arrête, l'autre s'arrête également, à moins qu'il ne gère explicitement les sorties (trap_exit).

Usage: Le monitoring est souvent utilisé dans des situations où vous souhaitez être informé de l'arrêt d'un processus sans y être lié de manière critique. Le linking est utilisé quand les processus ont une dépendance de vie mutuelle, comme dans les arborescences de supervision, où la panne d'un processus doit entraîner la panne de ses processus liés pour une récupération cohérente.

#### 23.1.X Documentation officielle

- [Application](https://hexdocs.pm/elixir/1.16/Application.html)

### 23.2 TP

#### 23.2.1 Objectifs


Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/23%20-%20Monitoring/tp) :

L'objectif de ce TP est de mettre en place un système de monitoring afin:
- De savoir si un utilisateur crash lors d'une partie de connect4
- De pouvoir redémarrer le processus de gestion d'action d'un utilisateur en cas de crash

Dans le module **Connect4Telnet.Endpoint** :
  - Ajoutez à la supervision un **TaskSupervisor** qui supervisera les connexions telnet
  - Modifiez la fonction `listen_loop/1` afin d'utiliser le **TaskSupervisor** pour démarrer une tâche qui gère la connexion telnet de l'utilisateur

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```


#### 23.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/23%20-%20Monitoring/correction).