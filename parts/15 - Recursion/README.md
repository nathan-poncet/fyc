## 15 Récursion

### 15.1 Cours

En Elixir, la récursion est souvent utilisée pour traiter des listes, des arbres et d'autres structures de données de manière efficace.

#### 15.1.1 Exemple de fonction Récursive

Voici un exemple simple d'une fonction récursive qui calcule la somme des éléments d'une liste en utilisant la récursion.

```elixir
defmodule MyList do
  def sum([]), do: 0  # Cas de base : liste vide, retourne 0
  def sum([head | tail]) when is_integer(head) do
    head + sum(tail)  # Appel récursif : additionne la tete + le total du reste de la liste (sum(tail))
  end
end

# Utilisation de la fonction sum/1 pour calculer la somme d'une liste
list = [1, 2, 3, 4, 5]
result = MyList.sum(list) # Résultat : 15
```

[Cours vidéo](https://youtu.be/CakOlA0LptE)
#### 15.1.2 Documentation officiel

- [Recursion](https://hexdocs.pm/elixir/1.16/recursion.html)

### 15.2 TP

#### 15.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/15%20-%20Recursion/tp) :

- Créez un fichier **lib/connect4_telnet/handler/formatter.ex** avec la fonction suivante :
  - public: `format_response/1` (Conn) -> retourne un message en fonction du status de la réponse
- Créez un fichier **lib/connect4_telnet/handler/parser.ex**
  - public: `parse/1` (Conn) -> parse la commande et retourne une Conn avec le path et les params parsés
  - private: `parse_params/2` (params_array, map) -> parse les paramètres de la requête (utiliser la recursion pour parser les paramètres).
    Exemple : `parse_params(["name=foo", "age=42"], %{})` -> `%{"name" => "foo", "age" => "42"}`
- Créez un fichier **lib/connect4_telnet/handler/router.ex**
  - public: `route/1` (Conn) -> choisi la bonne fonction en fonction de la requête du client. (créer plusieurs exemples non-fonctionnel en fonction des actions à réaliser pour le jeu)

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 15.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/15%20-%20Recursion/correction).
