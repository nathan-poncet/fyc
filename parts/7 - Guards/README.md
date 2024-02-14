## 7 Guards

### 7.1 Cours

Les guards en Elixir sont des expressions booléennes qui sont utilisées pour spécifier des conditions supplémentaires dans la définition des fonctions. Ils permettent de restreindre les cas dans lesquels une clause de fonction particulière peut être exécutée. Les guards sont souvent utilisés avec le mot-clé **when** pour définir des conditions.

#### 7.1.1 Utilisation des Guards dans une Clause

Les guards sont couramment utilisés dans la définition de fonctions pour spécifier des conditions qui doivent être remplies pour qu'une clause de fonction soit exécutée.

```elixir
defmodule Math do
  # Cette clause de fonction s'exécute si l'argument est égal à zéro
  def zero?(0), do: true

  # Cette clause de fonction s'exécute si l'argument est un entier (utilisation de guard)
  def zero?(x) when is_integer(x), do: false
end
```

Dans cet exemple, la première clause de la fonction **zero?/1** s'exécute si l'argument est égal à zéro. La deuxième clause de fonction s'exécute si l'argument est un entier, comme spécifié par le guard **when is_integer(x)**.

#### 7.1.2 Utilisation des Guards dans des Fonctions Anonymes

Les guards peuvent également être utilisés dans des fonctions anonymes, ce qui permet de spécifier des conditions pour le traitement des données.

```elixir
# Utilisation d'un guard dans une fonction anonyme
f = fn
  x when x > 0 -> "Positif"
  x when x < 0 -> "Négatif"
  _ -> "Zéro"
end

f.(5)   # Résultat: "Positif"
f.(-3)  # Résultat: "Négatif"
f.(0)   # Résultat: "Zéro"
```

#### 7.1.3 Documentation officiel

- [Clauses et Guards](https://hexdocs.pm/elixir/1.16/anonymous-functions.html#clauses-and-guards)

### 7.2 TP

#### 7.2.1 Objectifs

Repartir du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/7%20-%20Guards/tp) et compléter le fichier **game.ex**:
- Utiliser un guard sur la méthode **move/3** pour vérifier que le joueur ne dépasse pas du plateau (Entre 0 et le nombre de colonnes configuré).
- Utiliser un guard sur la méthode **board_generate/2** pour vérifier que le nombre de lignes et de colonnes et supérieur à 0. Réaliser une surcharge générique de la méthode qui génère un plateau de 6x7. Cette surcharge sera utilisée si le guard n'est pas satisfait.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```
#### 7.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/7%20-%20Guards/correction).

[Correction Vidéo](https://youtu.be/YXcYAbVL-sg)
