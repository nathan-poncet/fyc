## 16 Await & Task

### 16.1 Cours

ans ce chapitre, nous allons voir l'utilisation de **Task** pour gérer des tâches asynchrones et la communication entre processus.

#### 16.1.1 Utilisation de Task

La gestion de tâches asynchrones est facilitée par le module **Task**. Vous pouvez créer et exécuter des tâches asynchrones en utilisant **Task.async/1** pour les créer et **Task.await/2** pour attendre leur résultat.

```elixir
# Création d'une tâche asynchrone
task = Task.async(fn -> do_work() end)

# Attente de la fin de la tâche et récupération du résultat
result = Task.await(task)

# Utilisation du résultat
IO.puts("Task result: #{result}")
```

#### 16.1.2 Communication entre Processes

La communication entre les processus se fait principalement par l'envoi de messages, comme expliqué précédemment. Cependant, **Task** peut également être utilisé pour coordonner des tâches asynchrones en leur permettant de s'envoyer des messages.

```elixir
# Création de deux tâches asynchrones
task1 = Task.async(fn -> send_message(task2, "Hello from Task 1!") end)
task2 = Task.async(fn -> receive_message() end)

# Attente de la fin des tâches
Task.await(task1)
Task.await(task2)

# Fonction pour envoyer un message à une tâche
def send_message(task, message) do
  Task.put(task, {:message, message})
end

# Fonction pour recevoir un message dans une tâche
def receive_message do
  message = Task.get(self(), fn message -> message end)
  IO.puts("Received: #{inspect(message)}")
}
```

[Cours vidéo](https://youtu.be/8kzNXrI1GTI)
#### 16.1.3 Documentation officiel

- [Task](https://hexdocs.pm/elixir/1.16/Task.html)

### 16.2 TP

#### 16.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/16%20-%20Await%20&%20Task/tp) :

Comprendre comment executer des tâches asynchrones avec **Task** et comment communiquer entre processus.

- Créez un fichier **lib/connect4/utils/job.ex** avec les fonctions suivantes :
  - public: `async/1` (fn) -> démarre une tâche asynchrone
  - public: `await/1` (pid) -> attend la fin de la tâche et retourne le résultat
- Créez un fichier **lib/connect4/game/info.ex** avec les fonctions suivantes :
  - public: `get_random_funfacts_sync/1` (num) -> retourne un nombre de funfacts aléatoires en appelant de manière synchrone la fonction `call_funfact_api/0`
  - public: `get_random_funfacts_async/1` (num) -> retourne un funfact aléatoire en utilisant les fonctions `async/1` et `await/1` du module **Job**.
    Puis faire des versions avec l'utilisation de **process** (send/1 & receive), de **Task**, et de **Task.async_stream**.
  - private: `call_funfact_api/0` -> retourne un funfact aléatoire (fake api call) avec un délai de 1s (sauf test mode)

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 16.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/16%20-%20Await%20&%20Task/correction).
