## 17 Serveur avec état

### 17.1 Cours

#### 17.1.1 Principe d'immutabilité

L'immutabilité est un concept fondamental dans le développement avec Elixir. Cela signifie qu'une fois qu'une donnée est créée, elle ne peut être modifiée. Cette propriété est cruciale pour la programmation fonctionnelle et offre plusieurs avantages, notamment en termes de sûreté de concurrence et de prévisibilité du code. Dans un environnement concurrent comme celui d'Elixir, où de nombreux processus peuvent s'exécuter en parallèle, l'immutabilité empêche les états partagés de conduire à des situations indésirables telles que les conditions de course.

#### 17.1.2 Utiliser les processus pour gérer l'état

Elixir, étant construit sur la machine virtuelle Erlang (BEAM), tire parti de processus légers et isolés pour gérer la concurrence. Chaque processus a son propre espace d'adressage et communique avec d'autres processus via l'envoi de messages, suivant ainsi le modèle d'acteur.

##### Démarrage du serveur et initialisation de l'état

##### Processus et État

Dans Elixir, chaque processus fonctionne comme une entité autonome avec son propre espace d'état isolé. Cette isolation est fondamentale pour assurer la fiabilité et la scalabilité des applications Elixir. Lorsqu'il s'agit de gérer l'état dans un processus (comme un serveur), cela signifie que l'état est conservé localement dans le processus et ne peut être modifié que par le processus lui-même. Cela contraste avec d'autres paradigmes de programmation où l'état peut être partagé et accessible de manière globale, menant potentiellement à des problèmes de concurrence.

##### Stratégie de Gestion de l'État

La gestion de l'état dans un processus Elixir repose sur une boucle de réception, qui écoute et traite les messages entrants. À chaque itération de cette boucle, le processus peut recevoir un message, mettre à jour son état en conséquence, et attendre le prochain message. Voici comment cela fonctionne généralement :

Initialisation : Le processus est lancé avec un état initial. Cet état est souvent passé comme argument lors de la création du processus.

Boucle de Réception : Le processus entre dans une boucle de réception, où il attend les messages. Cette boucle est le cœur de la gestion de l'état.

Traitement des Messages : Lorsqu'un message est reçu, le processus utilise les données du message pour effectuer des opérations, ce qui peut inclure la mise à jour de son état. Le nouvel état est le résultat de l'application d'une fonction à l'état actuel et aux données du message.

Passage d'État : Après le traitement, l'état mis à jour est passé à la prochaine itération de la boucle de réception. Cela garantit que l'état est préservé entre les traitements de messages.

Réponse : Pour les messages qui nécessitent une réponse, le processus envoie une réponse après la mise à jour de l'état, avant de passer à la prochaine itération de la boucle.

##### Immutabilité de l'État

L'immutabilité joue un rôle crucial dans ce modèle. L'état d'un processus n'est jamais modifié "sur place". Au lieu de cela, chaque mise à jour crée une nouvelle version de l'état qui remplace l'ancienne dans la prochaine itération de la boucle. Cela simplifie la gestion de l'état et évite les problèmes de concurrence, car il n'y a jamais de mutation d'état partagé.

##### Exemple Conceptuel

Imaginons un serveur simple qui gère un compteur. L'état initial du serveur pourrait être 0. Chaque fois que le serveur reçoit un message pour incrémenter le compteur, il met à jour son état en ajoutant 1 à l'état actuel. Dans une boucle de réception, cela se traduirait par :

```elixir
def listen_loop(state) do
  receive do
    :increment ->
    new_state = state + 1
    listen_loop(new_state) # Passage du nouvel état à la prochaine itération
  end
end
```

### 17.2 TP

#### 17.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/17%20-%20Stateful%20Server/tp) :

Comprendre comment utiliser les processus pour gérer l'état d'un serveur.

- Créez un fichier **lib/connect4/utils/generic_server.ex** avec les fonctions suivantes :
  - public: `start/1` (fn) -> démarre le serveur
  - public: `call/2` (pid, message) -> envoie un message au serveur et attend la réponse
  - public: `cast/2` (pid, message) -> envoie un message au serveur sans attendre de réponse
  - private: `listen_loop/1` (state) -> boucle de réception du serveur qui gère l'état
- Créez un fichier **lib/connect4/games/server.ex** avec les fonctions suivantes (utiliser `GenericServer`) :
  - public: `start/1` (init_arg) -> démarre le serveur
  - public: `init/1` (init_arg) -> initialise l'état du serveur en retournant un tuple une `Game`
  - public: `join/2` (pid, player) -> ajoute un joueur au serveur
  - public: `leave/2` (pid, player_id) -> supprime un joueur du serveur
  - public: `move/3` (pid, player_id, column) -> ajoute un pion dans une colonne
  - public: `game/1` (pid) -> retourne l'état de la partie
  - public: `handle_call/3` (message, from, state) -> gère les messages synchrones proventant des fonctions publiques ci-dessus

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 17.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/17%20-%20Stateful%20Server/correction).
