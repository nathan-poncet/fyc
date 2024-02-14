## 13 Server Telnet

### 13.1 Cours

#### 13.1.1 Erlang

Elixir est construit sur la machine virtuelle Erlang (BEAM) et peut utiliser toutes les bibliothèques Erlang existantes. Cette interopérabilité avec Erlang offre aux développeurs Elixir une immense flexibilité et puissance, leur permettant de tirer parti des bibliothèques Erlang bien établies et performantes pour le réseau, le système de fichiers, la concurrence, et bien plus.

#### 13.1.2 Intégration des Bibliothèques Erlang

Pour utiliser une bibliothèque Erlang dans un projet Elixir, il suffit de l'appeler directement avec sa syntaxe habituelle. Les bibliothèques Erlang standard sont immédiatement accessibles dans tout projet Elixir sans nécessiter d'installation supplémentaire. Pour les bibliothèques Erlang tierces non incluses dans la distribution Erlang/OTP standard, il peut être nécessaire de les ajouter comme dépendances dans le fichier mix.exs du projet.

#### 13.1.3 Utilisation de gen_tcp

Le module :gen_tcp est une interface Erlang pour la programmation de sockets TCP, offrant un contrôle complet sur la création, la gestion et la fermeture des connexions TCP. Ce module est essentiel pour le développement d'applications nécessitant des communications réseau fiables et performantes.

1. Ouvrir une connexion TCP
   Pour ouvrir une connexion TCP en tant que client, vous utilisez :gen_tcp.connect. Vous devez fournir l'adresse du serveur (comme une chaîne ou une tuple), le port, et une liste d'options.

```elixir
{:ok, socket} = :gen_tcp.connect('localhost', 1234, [:binary, packet: :line])
```

- :binary indique que les données reçues seront traitées en binaires.
- packet: :line signifie que chaque message est terminé par une nouvelle ligne. Vous pouvez ajuster cette option en fonction de votre protocole.

2. Écouter des connexions entrantes
   Pour écouter des connexions entrantes, vous utilisez :gen_tcp.listen et :gen_tcp.accept. D'abord, vous créez un socket d'écoute :

```elixir
{:ok, listen_socket} = :gen_tcp.listen(1234, [:binary, { :reuseaddr, true }])
```

Ensuite, pour accepter une connexion entrante :

```elixir
{:ok, socket} = :gen_tcp.accept(listen_socket) 3. Lire des données
```

3. Lire des données
   Pour lire des données du socket, utilisez :gen_tcp.recv. Vous pouvez spécifier un timeout (en millisecondes) et la taille des données à recevoir.

```elixir
{:ok, data} = :gen_tcp.recv(socket, 0)
```

0 signifie que la fonction attendra un paquet complet avant de retourner.

4. Écrire des données
   Pour envoyer des données, utilisez :gen_tcp.send. Vous devez passer le socket et les données à envoyer.

```elixir
:ok = :gen_tcp.send(socket, "Hello, world!\n")
```

Assurez-vous que les données envoyées respectent le protocole que vous avez défini (par exemple, terminer par une nouvelle ligne si vous avez défini packet: :line).

5. Fermer la connexion
   Pour fermer le socket, utilisez :gen_tcp.close.

```elixir
:gen_tcp.close(socket)
```

Conseils supplémentaires:
- Gérez les erreurs en utilisant des tuples {:ok, result} et {:error, reason} pour vous assurer que votre application peut réagir correctement aux problèmes de réseau.
- Utilisez des processus ou des tâches pour gérer les connexions et la lecture/écriture de manière asynchrone, pour ne pas bloquer votre application.

#### 13.1. Documentation officiel

- [Librairies Erlang](https://hexdocs.pm/elixir/1.16/erlang-libraries.html)
- [gen_tcp](https://hexdocs.pm/elixir/1.16/task-and-gen-tcp.html)

### 13.2 TP

Expliquer les principes du fichier endpoint.ex et le fait que gentcp est une lib basé sur erlang et que elixir peut utiliser

Un serveur Telnet est un programme qui permet aux utilisateurs de se connecter à distance à un serveur et d'interagir avec lui via une interface en ligne de commande. En Elixir, vous pouvez créer un serveur Telnet en utilisant la librairie Erlang :gen_tcp, qui fournit des fonctionnalités pour gérer les connexions TCP.

La librairie Erlang :gen_tcp est utilisée pour gérer les connexions TCP. Elle permet de créer un socket d'écoute sur un port spécifique, d'accepter les connexions entrantes, de lire et d'écrire des données sur les sockets.

### 13.2 TP

#### 13.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/13%20-%20Server%20Telnet/tp) :

Créez un serveur Telnet qui accepte les connexions entrantes et affichez les données envoyées par les clients.

- Créez un fichier **lib/connect4_telnet/conn.ex** qui contient la structure de la connexion suivante : ``{params: [], path: [], pid: nil, response: "", request: "", socket: nil, status: :ok}``
- Créez un ficher **lib/connect4_telnet/endpoint.ex** avec les fonctions suivantes:
  - public: `accept/1` (port) -> lance le serveur sur le port spécifié avec la fonction `:gen_tcp.listen`
  - private: `loop_acceptor/1` (socket) -> boucle infinie qui accepte les connexions entrantes avec la fonction `:gen_tcp.accept`
  - private: `serve/1` (Conn) -> lit la requête du client, traite la requête et lui renvoie une réponse.
  - private: `read_request/1` (Conn) -> lit la requête du client avec la fonction `:gen_tcp.recv`
  - private: `send_response/1` (Conn) -> envoie la réponse au client avec la fonction `:gen_tcp.send`
- Créez un fichier **lib/connect4_telnet/handler.ex** avec les fonctions suivantes:
   - public: `handle/1` (Conn) -> traitant la requête du client.
   - private: `parse/1` (Conn) -> parse la requête du client.
   - private: `route/1` (Conn) -> choisi la bonne fonction en fonction de la requête du client.
   - private: `format_response/1` (Conn) -> formate la réponse du serveur.


Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :
```bash
mix test
```

#### 13.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/13%20-%20Server%20Telnet/correction).