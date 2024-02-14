## 5 Enum & fonctions anonymes
### 5.1 Cours
#### 5.1.1 Enum
Le module **Enum** en Elixir offre un ensemble d'algorithmes puissants pour itérer, filtrer, combiner et transformer des collections de manière élégante et fonctionnelle.
##### 5.1.1.1 Enum.map()
La fonction **Enum.map/2** permet de transformer chaque élément d'une liste en appliquant une fonction spécifiée.
```elixir
nombres = [1, 2, 3, 4, 5]

# Utilisation de Enum.map pour doubler chaque élément de la liste
resultat = Enum.map(nombres, fn x -> x * 2 end)

# Résultat attendu : [2, 4, 6, 8, 10]
```
##### 5.1.1.2 Enum.sort()
La fonction **Enum.sort/2** permet de trier une liste en utilisant une fonction de comparaison personnalisée.
```elixir
nombres = [5, 2, 8, 1, 9, 3]

# Trie la liste de nombres en ordre croissant
liste_triee = Enum.sort(nombres, fn a, b -> a <= b end)

# Résultat attendu : [1, 2, 3, 5, 8, 9]
```
##### 5.1.1.3 Enum.filter()
La fonction Enum.filter/2 permet de filtrer les éléments d'une liste en utilisant une fonction de prédicat pour déterminer quels éléments doivent être inclus.
```elixir
nombres = [1, 2, 3, 4, 5, 6, 7, 8, 9]

# Filtre les nombres pairs en utilisant Enum.filter
nombres_pairs = Enum.filter(nombres, fn x -> rem(x, 2) == 0 end)

# Résultat attendu : [2, 4, 6, 8]
```

#### 5.1.2 Fonctions Anonymes
##### 5.1.2.1 Définition de Fonctions Anonymes
Les fonctions anonymes sont définies avec **fn** et **end** et peuvent être assignées à des variables.
```elixir
addition = fn a, b -> a + b end
addition.(1, 2)  # Résultat: 3
```
##### 5.1.2.1 Closure
Les fonctions anonymes en Elixir peuvent capturer des variables de leur environnement, formant une closure.
```elixir
x = 10
capture_x = fn a -> a + x end
capture_x.(5)  # Résultat: 15
```
#### 5.1.3 L'Opérateur Pin 
L'opérateur pin (^) est utilisé pour accéder à la valeur d'une variable dans le Pattern Matching.
```elixir
x = 1
^x = 2 # Soulève une erreur car x n'est pas 1
{^x, y} = {1, 2}  # Correspond, x est 1
{^x, y} = {3, 4}  # Soulève une erreur car x n'est pas 3
```
#### 5.1.4 Documentation officiel
- [Pin operator](https://hexdocs.pm/elixir/1.16/pattern-matching.html#the-pin-operator)
- [Fonctions Anonymes](https://hexdocs.pm/elixir/1.16/anonymous-functions.html#content)
- [Enum](https://hexdocs.pm/elixir/1.16/enumerable-and-streams.html)

### 5.2 TP

#### 5.2.1 Objectifs
Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/5%20-%20Enum%20&%20Anonymous%20function/tp) et complétez le fichier **game.ex** en créant 3 nouvelles fonctions :

- **join/2** (game, player) doit permettre d'ajouter un joueur à la partie
- **leave/2** (game, player_id) doit permettre de retirer un joueur de la partie
- **move/3** (game, player, col_index) doit permettre de déplacer un joueur dans la partie en 3 étapes :
  - Trouver le row index correspondant à la colonne
  - Placer la pièce du joueur dans la colonne
  - Retourner l'état de la partie mis à jour

Modifiez la fonction **create/0** en **create/3** (player, name, settings) afin que la partie soit initialisée avec le player qui a créé la partie ainsi que la génération du board (Tableau de jeu).

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 5.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/5%20-%20Enum%20&%20Anonymous%20function/correction).
