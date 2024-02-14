## 24 Application

### 24.1 Cours

Une application Elixir est généralement un ensemble de modules et de fichiers de configuration qui forment une unité fonctionnelle. Elle peut être démarrée ou arrêtée comme une entité unique et peut dépendre d'autres applications. Ceci est particulièrement utile pour construire des systèmes complexes en assemblant différentes applications, qu'elles soient internes à votre projet ou des bibliothèques externes.

#### 24.1.1 Structure d'une Application

Une application typique sous Elixir est structurée autour d'un fichier de mix, qui définit les métadonnées de l'application, ses dépendances et ses tâches. Le fichier mix.exs à la racine du projet contient la définition de l'application, y compris son nom, sa version, ses points d'entrée et ses dépendances.

```elixir
defmodule MyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_app,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MyApp.Application, []}
    ]
  end

  defp deps do
    []
  end
end
```

Dans cet exemple, la clé mod: {MyApp.Application, []} spécifie le module de démarrage de l'application et ses arguments initiaux, qui sont utilisés pour démarrer le processus racine de l'application, souvent un superviseur.

#### 24.1.2 Démarrage et Arrêt d'une Application

Une application Elixir peut être démarrée manuellement en utilisant Application.start/2 ou automatiquement par Elixir lors du démarrage de votre système. Le processus de démarrage invoque la fonction start/2 du module spécifié dans la configuration mod de l'application, qui est responsable de l'initialisation de l'application, généralement en démarrant son arbre de supervision.

```elixir
defmodule MyApp.Application do
  use Application

  def start(\_type, \_args) do
    children = [
      # Liste des processus enfants, comme les superviseurs et les travailleurs
    ]

    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

L'arrêt d'une application se fait en inversant le processus de démarrage, en arrêtant d'abord les processus enfants avant de terminer le processus racine.

#### 24.1.3 Configuration
Les applications Elixir peuvent être configurées à l'aide de fichiers de configuration, souvent situés dans le répertoire config/ de votre projet. La configuration est accessible via Application.get_env/3 et modifiable via Application.put_env/4, permettant de personnaliser le comportement de l'application en fonction de l'environnement d'exécution.

#### 24.1.4 Dépendances
Les applications peuvent dépendre d'autres applications Elixir ou Erlang. Ces dépendances sont déclarées dans le fichier mix.exs et sont automatiquement démarrées avant l'application dépendante, garantissant que toutes les fonctionnalités requises sont disponibles.

#### 24.1.X Documentation officielle

- [Application](https://hexdocs.pm/elixir/1.16/Application.html)

### 24.2 TP

#### 24.2.1 Objectifs


Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/24%20-%20Application/tp) :

Notre application est maintenant fonctionnelle, mais elle ne peut pas être démarrée en tant qu'application Elixir. 
L'objectif de ce TP est de transformer notre application en une application Elixir à l'aide du module **Application**.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 24.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/24%20-%20Application/correction).