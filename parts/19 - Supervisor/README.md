## 19 Supervisor

### 19.1 Cours

Les superviseurs sont des processus conçus pour surveiller d'autres processus. Ils permettent de gérer la tolérance aux pannes. Le module **Supervisor** est généralement utilisé pour superviser des processus longs comme des serveurs

#### 19.1.1 Rôle et Importance des Superviseurs

Un superviseur est un processus qui contrôle le cycle de vie d'autres processus, appelés processus enfants. Sa principale fonction est de surveiller ces processus enfants et de gérer le crash de l'un d'entre eux.

#### 19.1.2 Stratégies de Supervision

Les principales stratégies de supervision en Elixir sont :

- **:one_for_one** : Redémarre uniquement le processus enfant défaillant.
- **:one_for_all** : Redémarre tous les processus enfants si l'un d'eux échoue.
- **:rest_for_one** : Redémarre le processus enfant défaillant ainsi que ceux qui ont été lancés après lui.

#### 19.1.3 Exemple de Superviseur

```elixir
defmodule MySupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(arg) do
    children = [
      {MyWorker, arg},
      {AnotherWorker, []}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
```

Dans cet exemple **MySupervisor** est un superviseur personnalisé utilisant la stratégie **:rest_for_one**. Il supervise deux processus enfants, **MyWorker** et **AnotherWorker**. Si **MyWorker** échoue, lui et tous les processus lancés après lui (dans ce cas, **AnotherWorker**) seront redémarrés.

#### 19.1.4 Documentation officiel

- [Superviseur](https://hexdocs.pm/elixir/1.16/Supervisor.html)

### 19.2 TP

#### 19.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/19%20-%20Supervisor/tp) :

- Créez un module **Connect4.Games.Supervisor** dans le fichier **lib/connect4/games/supervisor.ex** avec une liste d'enfants vide
- Modifiez le module **Connect4Telnet.Endpoint** afin de démarrer un superviseur avec une tache qui lance le serveur telnet

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 19.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/19%20-%20Supervisor/correction).
