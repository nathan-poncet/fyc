## 21 DynamicSupervisor et Registry

### 21.1 Cours

#### 21.1.1 DynamicSupervisor

**DynamicSupervisor** est une variante du superviseur standard en Elixir. Il est conçue pour démarrer des processus de manière dynamique contrairement à un superviseur ordinaires qui démarre ses enfants au démarrage. **DynamicSupervisor** permet d'ajouter ou de supprimer des processus enfants au fil du temps.

```elixir
defmodule MyApp.DynamicSupervisorExample do
  use DynamicSupervisor

  def start_link do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  # Fonction pour démarrer un nouveau processus enfant
  def add_child(child_spec) do
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end
```

**MyApp.DynamicSupervisorExample** est un **DynamicSupervisor**. La fonction **add_child/1** permet d'ajouter dynamiquement un processus enfant à ce superviseur. La stratégie de supervision **:one_for_one** est utilisée. Si un processus enfant échoue, seul ce processus sera redémarré.

#### 21.1.2 Registry avec :via

Le **Registry** permet d'enregistrer et localiser des processus au dans une application. L'utilisation de **:via** permet d'enregistrer des processus sous des noms personnalisés, facilitant la gestion dans des environnements complexes ou distribués.

```elixir
defmodule MyApp.MyWorker do
  use GenServer

  # Fonction pour démarrer le GenServer avec un nom personnalisé via le Registry
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: {:via, Registry, {MyApp.Registry, name}})
  end

  def init(:ok) do
    {:ok, %{}}
  end
end

defmodule MyApp.Registry do
  use Registry, keys: :unique, name: MyApp.Registry
end
```

**MyApp.MyWorker** est un **GenServer** qui est démarré avec un nom unique en utilisant **:via** et **Registry**. **MyApp.Registry** est un **Registry** utilisé pour enregistrer chaque instance de **MyApp.MyWorker** avec un nom unique.

#### 21.1.3 Documentation officielle

- [DynamicSupervisor](https://hexdocs.pm/elixir/1.16/DynamicSupervisor.html)
- [Registry :via](https://hexdocs.pm/elixir/1.13.4/Registry.html#module-using-in-via)

### 21.2 TP

#### 21.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/16%20-%20Await%20&%20Task/tp) :

- Modifiez le module **Connect4.Games.Supervisor** :
  - Ajoutez un **DynamicSupervisor** au **Supervisor** pour gérer les parties
  - Ajoutez un **Registry** (clé unique) au **Supervisor** pour enregistrer les parties
  - Ajoutez une fonction **game_create/3** qui utilise le **DynamicSupervisor** pour démarrer une partie
- Modifiez le module **Connect4.Games.Server** :
  - Utilisez le **Registry** pour enregistrer un partie (`via_tuple(code)`)
  - Utilisez le **Registry** pour appeler les fonctions de la partie
- Ajoutez une fonction delegate **game_create/3** dans le module **Connect4.Games**

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 21.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/21%20-%20Dynamic%20Supervisor%20&%20Registry/correction).
