## 14 Les processes et l'asynchrone

### 14.1 Cours

Les processes (processus) sont des unités d'exécution légères qui permettent de gérer des tâches en parallèle. Ils sont créés et gérés par le système d'exécution d'Elixir, appelé OTP (Open Telecom Platform). Les processes en Elixir sont différents des threads ou des processus lourds dans d'autres langages, car ils sont hautement concurrents et ne partagent pas de mémoire.

#### 14.1.1 Process ID (PID)

Chaque processus en Elixir est identifié par un PID, qui est un identifiant unique. Le PID est une référence permettant d'interagir avec un processus spécifique. Vous pouvez envoyer des messages à un processus en utilisant son PID, surveiller son état, ou même le tuer si nécessaire.

#### 14.1.2 Asynchrone

L'une des caractéristiques les plus importantes des processes en Elixir est qu'ils fonctionnent de manière asynchrone. Cela signifie que plusieurs processes peuvent s'exécuter en parallèle et communiquer entre eux sans attendre les uns les autres. Chaque processus a son propre flux d'exécution indépendant et peut fonctionner de manière autonome.

#### 14.1.3 Création et Gestion de Processes

Vous pouvez créer un nouveau processus en utilisant la fonction **spawn/1** ou **spawn/3**. Par exemple, pour créer un nouveau processus qui exécute une fonction appelée my_function.

```elixir
pid = spawn(fn -> my_function() end)
```

#### 14.1.4 Documentation officiel

- [Spawning Processes](https://hexdocs.pm/elixir/1.16/processes.html#spawning-processes)

### 14.2 TP

#### 14.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/14%20-%20Processes/tp) :

Afin de pouvoir accepter plusieurs connexions en même temps, vous devez créer un processus pour chaque connexion entrante :

- Pour cela, vous pouvez utiliser la fonction spawn/1 pour créer un nouveau processus qui exécute une fonction spécifique.
- `:ok = :gen_tcp.controlling_process(client, pid)` permet de lier socket au processus créé. Ainsi, si le processus parent meurt, le processus enfant restera actif.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 14.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/14%20-%20Processes/correction).
