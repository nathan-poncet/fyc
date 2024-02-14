## 18 Gen serveur

### 18.1 Cours

Les GenServers sont une abstraction puissante dans Elixir pour créer des serveurs dans des applications concurrentes. Ils font partie des comportements OTP (Open Telecom Platform) et fournissent une structure pour implémenter des serveurs d'arrière-plan qui gèrent l'état, exécutent des tâches en arrière-plan et répondent aux requêtes. Nous allons explorer comment fonctionnent les GenServers, comment en lancer un, leur processus d'initialisation et les fonctions de callback essentielles.

#### 18.1.1 Comment ça marche ?

Un GenServer est un processus qui encapsule un état et fournit une interface synchrone (call) et asynchrone (cast) pour interagir avec ce processus. Les requêtes call sont bloquantes et attendent une réponse, tandis que les requêtes cast sont non bloquantes et ne fournissent pas de réponse.

Les GenServers traitent les requêtes dans une boucle séquentielle, garantissant que chaque message est traité de manière atomique. Cela simplifie la gestion de l'état en évitant les conditions de course et les verrouillages.

#### 18.1.2 Lancer un GenServer

Pour démarrer un GenServer, vous pouvez utiliser la fonction GenServer.start_link/3. Cette fonction crée et lie un nouveau processus GenServer au processus appelant. En cas d'arrêt de l'un des processus, l'autre s'arrête également, ce qui assure une supervision et une récupération d'erreur efficaces.

```elixir
{:ok, pid} = GenServer.start_link(MyGenServer, :initial_state, [name: MyGenServer])
```

Dans cet exemple, MyGenServer est le module implémentant le comportement GenServer, :initial_state est l'état initial passé à la fonction init/1, et l'option [name: MyGenServer] donne un nom au GenServer pour une référence simplifiée.

#### 18.1.3 Initialisation

L'initialisation d'un GenServer se fait via la fonction de callback init/1, qui est appelée immédiatement après que le processus GenServer a été créé. Cette fonction doit retourner {:ok, state}, où state est l'état initial du GenServer.

```elixir
defmodule MyGenServer do
  use GenServer

  def init(initial_state) do
    {:ok, initial_state}
  end
end
```

#### 18.1.4 Fonctions de Callback

Les GenServers définissent plusieurs fonctions de callback pour gérer différentes requêtes:

handle_call/3: Gère les appels synchrones. Elle prend la requête, le PID de l'appelant et l'état actuel, et doit retourner une tuple {:reply, response, new_state} pour envoyer une réponse à l'appelant et mettre à jour l'état.

handle_cast/2: Gère les appels asynchrones. Elle prend la requête et l'état actuel, et doit retourner {:noreply, new_state} pour indiquer qu'aucune réponse ne sera envoyée et mettre à jour l'état.

handle_info/2: Gère les messages non sollicités, comme les messages envoyés directement au processus GenServer en dehors de l'API call ou cast.

```elixir
def handle_call(:get_state, \_from, state) do
  {:reply, state, state}
end

def handle_cast({:update_state, value}, state) do
  {:noreply, state + value}
end
```

Dans l'exemple ci-dessus, handle_call/3 répond à la requête :get_state en retournant l'état actuel, tandis que handle_cast/2 met à jour l'état en ajoutant une valeur à l'état actuel pour la requête {:update_state, value}.

[Cours vidéo](https://youtu.be/OD702ChHLkM)
### 18.2 TP

#### 18.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/16%20-%20Await%20&%20Task/tp) :

- Remplacez le `GenericServer` par un `GenServer` dans le fichier **lib/connect4/games/server.ex**
- Completez le module `Connect4.Games` en delegant les fonctions du `GenServer` au module `Connect4.Games`
- Completez les fonctions `route/1` du fichier **lib/connect4_telnet/handler/router.ex** avec les fonctions disponibles dans le module `Connect4.Games`

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 18.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/18%20-%20Gen%20Server/correction).
