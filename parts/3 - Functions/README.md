## 3 Fonctions

### 3.1 Cours

#### 3.1.1 Modules et Fonctions

Les fonctions en Elixir sont définies à l'intérieur de modules. Un module permet de regrouper plusieurs fonctions et est défini avec **defmodule**, tandis que les fonctions à l'intérieur du module sont définies avec **def**.

```elixir
# Déclaration du module MonModule
defmodule MonModule do
  # Déclaration de la fonction ma_fonction
  def ma_fonction do
    IO.puts "Hello World!"
  end

   # Déclaration de la fonction addition qui a comme arguments a et b
   def addition(a, b) do
    a + b
  end
end

# Appel des fonctions
MonModule.ma_fonction()
resultat = MonModule.addition(5, 3)  # Résultat: 8
```

#### 3.1.2 Arguments par Défaut

Elixir permet de définir des valeurs par défaut pour les arguments des fonctions. Ceci est réalisé en utilisant la syntaxe \\ après le nom de l'argument.

```elixir
defmodule Math do
  def addition(a, b \\ 0) do
    a + b
  end
end

# Utilisation de la valeur par défaut
resultat1 = Math.addition(5)  # Résultat: 5 (5 + 0)

# Spécification des deux arguments
resultat2 = Math.addition(5, 3)  # Résultat: 8
```

#### 3.1.3 Documentation officiel

- [Modules et fonctions](https://hexdocs.pm/elixir/1.16/modules-and-functions.html#content)

### 3.2 TP

#### 3.2.1 Objectifs

- Créez un nouveau projet avec mix
  ```bash
  mix new connect_4
  ```
- Récupérez le dossier [test](https://github.com/nathan-poncet/fyc/blob/main/parts/3%20-%20Functions/tp) et placez-le à la racine du projet ou remplacez le dossier test actuel.
- Créez un module Connect4.Game dans le fichier **lib/connect4/game.ex**
- Le fichier **game.ex** contient 3 fonctions
  - Une fonction **create/0**
    - Cette fonction ne prend aucun argument
    - Elle renvoie une structure de données (map) de jeu avec le statut :lobby
  - Une fonction **start/1**
    - Prend un argument **game** qui est l'état actuel du jeu
    - Met à jour l'état du jeu en changeant son statut en **:playing**. Le jeu passe du mode **:lobby** au mode de **:playing**.
  - Une fonction **lobby/1**
    - Prend également un argument **game**.
    - Met à jour l'état du jeu pour définir son statut en **:lobby**. Le jeu est terminé.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 3.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/3%20-%20Functions/correction).

[Correction Vidéo](https://youtu.be/MAL1eqqNfN0)
