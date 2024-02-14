## 9 Module & doc
### 9.1 Cours
Les modules en Elixir sont des conteneurs qui regroupent des fonctions et des données connexes. Ils sont utilisés pour organiser le code de manière logique et réutilisable. De plus, la documentation joue un rôle essentiel dans la clarté et la compréhension du code. Elixir offre des fonctionnalités puissantes pour documenter les modules et les fonctions.
#### 9.1.1 Utilisation de Module Attributes
Les module attributes sont utilisés pour stocker des métadonnées ou des valeurs configurables au niveau du module. Ils peuvent être définis à l'intérieur du module en utilisant **@**, suivi du nom de l'attribut et de sa valeur.
```elixir
defmodule MonModule do
  @pi 3.14

  def rayon(circonference) do
    circonference / (2 * @pi)
  end
end
```
#### 9.1.2 Documentation de Modules
La documentation des modules en Elixir est généralement placée juste en dessous de la déclaration du module. Elle est encadrée par **@moduledoc """** et **"""** et permet de fournir une description générale du module, son but, et d'autres informations pertinentes.
```elixir
defmodule MonModule do
  @moduledoc """
  Ce module contient des fonctions utiles pour effectuer diverses opérations mathématiques.
  """

  # Fonctions et données du module
end
```
#### 9.1.3 Documentation de Fonctions
La documentation des fonctions en Elixir se fait en plaçant une documentation juste au-dessus de la déclaration de la fonction. Elle est encadrée par **@doc """** et **"""** et permet de décrire la fonction, ses arguments, ses valeurs de retour, et des exemples d'utilisation.
```elixir
defmodule MonModule do
  @moduledoc """
  Ce module contient des fonctions utiles pour effectuer diverses opérations mathématiques.
  """

  @doc """
  Cette fonction calcule la somme de deux nombres.

  ## Exemples

      iex> MonModule.addition(3, 5)
      8

  """
  def addition(a, b) do
    a + b
  end
end
```
#### 9.1.4 Doctests
Les tests de documentation, également appelés "doctests", sont une façon pratique de s'assurer que les exemples de code inclus dans la documentation de votre module fonctionnent comme prévu. Les doctests sont exécutés automatiquement pour vérifier que les exemples dans la documentation donnent les résultats attendus.

Pour exécuter les tests de documentation dans un projet Elixir, vous pouvez utiliser la commande suivante dans votre terminal, en vous assurant d'être dans le répertoire de votre projet :
```shell
mix test --include doctest
```
Cette commande exécute tous les tests de documentation dans votre projet. Si un doctest échoue, vous verrez un message d'erreur indiquant quel exemple de code a échoué et quel était le résultat attendu.

```elixir
defmodule MyModule do
  @doc """
  Adds two numbers together.

  ## Examples

      iex> MyModule.add(2, 3)
      5

  """
  def add(a, b) do
    a + b
  end
end
```
Dans cet exemple, nous utilisons la directive @doc pour documenter la fonction **add/2** en incluant un exemple d'utilisation dans la documentation.
#### 9.1.5 Alias, Require et Import
Elixir permet d'importer des modules ou d'aliaser des modules pour simplifier l'accès à leurs fonctions et constantes. Par exemple, vous pouvez utiliser **alias** pour créer un raccourci vers un module, **require** pour charger un module, et **import** pour rendre les fonctions du module accessibles.
```elixir
alias MonAutreModule, as: Autre
require MonModule
import List, only: [flatten: 1]

Autre.ma_fonction()
MonModule.ma_fonction()
flatten([[1, 2], [3, 4]])  # Utilisation de la fonction importée
```
#### 9.1.6 Documentation officielle
- [Attributs de module](https://hexdocs.pm/elixir/1.16/module-attributes.html)
- [Doctests](https://hexdocs.pm/elixir/1.16/docs-tests-and-with.html#doctests)
- [Alias, Require et Import](https://hexdocs.pm/elixir/1.16/alias-require-and-import.html)

### 9.2 TP

#### 9.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/9%20-%20Module%20&%20Doc/tp) et complétez le dossier **lib** :
- Séparez les fonctions en modules :
  - Dans le dossier **lib** créez un dossier **games**
  - Dans le dossier **lib** créez un fichier **games.ex**, pour le moment ce module est vide, mais il contiendra plus tard la logique des games
  - Dans le dossier **lib/games** créez les fichiers **game.ex** et **board.ex**
  - Déplacer les fonctions relatives au board dans le fichier **board.ex**
  - Déplacer les fonctions relatives à la game dans le fichier **game.ex**
  - Documentez les modules et fonctions en utilisant doctest et les module attributes

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :
```bash
mix test
```
#### 9.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/9%20-%20Module%20&%20Doc/correction).