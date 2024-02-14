## 12 Struct
### 12.1 Cours
Les structs sont utilisées pour définir des données avec une structure particulière. Elles sont similaires aux maps, mais avec un ensemble prédéfini de clés et de types de données pour chaque clé. 
#### 12.1.1 Déclaration d'une struct
Les structs sont définies en utilisant le module **defstruct**.
```elixir
defmodule User do
  defstruct name: "", age: 0
end
```
Dans cet exemple, nous avons défini une **struct** **User** avec deux clés : **name** et **age**. Nous avons également spécifié leurs valeurs par défaut, " " (une chaîne vide) pour name et 0 pour age.
#### 12.1.2 Utilisation d'une struct
Une fois que vous avez défini une struct, vous pouvez créer des instances de celle-ci.
```elixir
# Création d'une instance de la struct User
user = %User{name: "Alice", age: 30}

# Modifictaion du name de user
user = %User{user | name: "Bob"}
```
#### 12.1.3 Documentation officiel
- [Structs](https://hexdocs.pm/elixir/1.16/structs.html)

### 12.2 TP

#### 12.2.1 Objectifs
Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/12%20-%20Struct/tp) et implémentez les structures :
- Créez un fichier **lib/games/player.ex** et implementez la structure ``{id: "", symbol: ""}``
- Implémentez la structure de **lib/games/game.ex** ``{name: "", board: [], players: [], settings: %{}, status: :lobby}``
- Ajoutez du patern matching sur un maximum de fonctions pour vérifier que les paramètres passés implémentent la bonne structure

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :
```bash
mix test
```

#### 12.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/12%20-%20Struct/correction).