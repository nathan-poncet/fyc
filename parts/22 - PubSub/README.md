## 22 PubSub

### 22.1 Cours

#### 22.1.1 Dispatcher

Le **Registry** peut être utilisé comme un **Dispatcher**, ce qui permet de distribuer des tâches ou des notifications à un groupe de processus.

```elixir
defmodule MyApp.Dispatcher do
  def send_message(name, message) do
    # Envoie un message à tous les processus ayant le meme name
    Registry.dispatch(MyApp.Registry, name, fn entries ->
      for {pid, _} <- entries, do: send(pid, message)
    end)
  end
end
```

**send_message/2** utilise **MyApp.Dispatcher** pour envoyer des messages à plusieurs processus.

#### 22.1.2 PubSub

Le **Registry** peut également être utilisé pour implémenter un système de publication/abonnement (**PubSub**). Les processus peuvent s'enregistrer pour écouter des sujets spécifiques. Lorsqu'un message est envoyé à un sujet, tous les processus abonnés à ce sujet reçoivent le message. Les sujets peuvent aussi agir en tant que publishers (émettre des messages).

```elixir
defmodule MyApp.PubSub do
  def subscribe(topic) do
    # Enregistrement pour écouter un sujet spécifique
    Registry.register(MyApp.Registry, topic, :subscribed)
  end

  def publish(topic, message) do
    # Publication d'un message sur un sujet spécifique
    Registry.dispatch(MyApp.Registry, topic, fn entries ->
      for {pid, _} <- entries, do: send(pid, message)
    end)
  end
end
```

**MyApp.PubSub** permet à un processus de s'abonner à un sujet **subscribe/1** et de publier des messages sur un sujet **publish/2**.

#### 22.1.3 Documentation officielle

- [Dispatcher](https://hexdocs.pm/elixir/1.16/Registry.html#module-using-as-a-dispatcher)
- [PubSub](https://hexdocs.pm/elixir/1.16/Registry.html#module-using-as-a-pubsub)

### 22.2 TP

#### 22.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/22%20-%20PubSub/tp) :

- Créez un module **Connect4.Utils.PubSub** qui demarre un **Supervisor** avec un **Registry** pour gérer les sujets
- Transformez le module **Connect4Telnet.Conn** en **GenServer**:
  - Déplacez les fonctions **serve/1**, **read_request/1** et **send_response/1** du module **Connect4Telnet.Endpoint** vers le module **Connect4Telnet.Conn**
  - Au démarrage du **GenServer**, lancer la fonction **serve/1** avec le **pid** en paramètre
  - Créez une fonction **handle_info/2** afin de recevoir les messages du **GenServer** envoyés par le pubsub
- Dans le module **Connect4.Games.Server**, broadcastez l'ensemble des messages utiles aux joueurs
- Dans le module **Connect4Telnet.Endpoint**:
  - Transformez le **TaskSupervisor** en **DynamicSupervisor**
  - Créez une fonction pour lancer un **Connect4Telnet.Conn** avec le **DynamicSupervisor**
- Dans le module **Connect4Telnet.Handler.Router**:
  - Lors de la creation d'une partie ou la connexion d'un joueur, souscrire l'utilisateur au sujet de la partie
  - Lorsque le joueur quitte la partie, le désabonner du sujet

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 22.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/22%20-%20PubSub/correction).
