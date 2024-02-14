## 10 Head & Tail
### 10.1 Cours
En Elixir, les concepts de **head** et **tail** sont couramment utilisés pour manipuler des listes chaînées. 
#### 10.1.1 Head (hd) et Tail
- Head (hd) : La **head** d'une liste est son premier élément.
- Tail (tail) : La **tail** d'une liste est le reste des éléments après le premier.
#### 10.1.2 Utilisation de Head et Tail
- hd(liste) : Cette fonction renvoie le premier élément de la liste.
- tl(liste) : Cette fonction renvoie la liste sans son premier élément.
```elixir
liste = [1, 2, 3, 4, 5]

# Obtenir le "head" (premier élément)
tete = hd(liste)  # tete est maintenant égal à 1

# Obtenir la "tail" (reste de la liste)
queue = tl(liste)  # queue est maintenant égal à [2, 3, 4, 5]
```
#### 10.1.3 Utilisation avec du pattern matching
Utilisation du pattern matching pour séparer le premier élément (head) d'une liste de ses éléments restants (tail).
```elixir
defmodule Exemple do
  def separer_head_tail([head | tail]) do
    {head, tail}
  end
end

ma_liste = [1, 2, 3, 4, 5]
{premier_element, reste_de_la_liste} = Exemple.separer_head_tail(ma_liste)

IO.inspect(premier_element) # Résultat : 1
IO.inspect(reste_de_la_liste) # Résultat : [2, 3, 4, 5]
```
#### 10.1.4 Documentation officiel
- [Pattern Matching](https://hexdocs.pm/elixir/1.16/pattern-matching.html)
- [Listes chainées](https://hexdocs.pm/elixir/1.16/lists-and-tuples.html#linked-lists)

### 10.2 TP

#### 10.2.1 Objectifs
Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/10%20-%20Head%20&%20Tail/tp) et complétez le fichier **game.ex**:
- Modifiez la fonction **move/3** :
  - Avec du patern matching, récupéré le joueur en cours (premier joueur de la liste)
  - Ne plus passer **player** en 2eme paramètre mais **player_id**
  - Vérifiez que le player_id est le joueur en cours
- Créer une fonction **next_player/1** (game)
  - La fonction passe en head le joueur devant jouer
  - Utilisez du patern matching avec head et tail

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :
```bash
mix test
```
#### 10.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/10%20-%20Head%20&%20Tail/correction).