## 4 Pattern Matching

### 4.1 Cours

Le Pattern Matching est une des caractéristiques les plus puissantes et distinctives d'Elixir. Il étend la notion d'affectation de variable pour permettre des structures plus complexes et des conditions de correspondance plus élaborées.

#### 4.1.1 Le Match Operator (=)

En Elixir, le symbole **=** est connu comme le match operator. Contrairement à d'autres langages où = représente une affectation, en Elixir, il est utilisé aussi pour vérifier si le côté gauche correspond au côté droit. Si la correspondance réussit, la valeur est retournée, sinon une erreur est levée.

```elixir
# Affectation simple
x = 1  # x est maintenant 1

# Pattern Matching
1 = x  # Correspond car x est 1

# Cela soulèvera une erreur car 2 ne correspond pas à x (qui est 1)
2 = x
```

#### 4.1.2 Pattern Matching avec des Tuples

Le Pattern Matching est particulièrement utile avec des structures de données comme les tuples pour extraire des valeurs.

```elixir
tuple = {:ok, "Hello"}

# Extraction de valeur avec Pattern Matching
{:ok, message} = tuple
# message est maintenant "Hello"

# Cela soulèvera une erreur car le pattern ne correspond pas
{:error, message} = tuple
```

#### 4.1.3 Ignorer des Valeurs avec _

Le caractère _ est utilisé en Elixir pour ignorer des parties lors du Pattern Matching.

```elixir
# Ignorer la deuxième valeur
{_, b} = {1, 2}
# b est maintenant 2, et la première valeur est ignorée
```

#### 4.1.4 Documentation officiel

- [Pattern matching](https://hexdocs.pm/elixir/1.16/pattern-matching.html)

### 4.2 TP

#### 4.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/4%20-%20Pattern%20Matching/tp) et complétez le fichier **game.ex**, ajoutez du patern matching:

- **start/1** doit verifier que le paramètre game est bien une map avec la clé **:status** à la valeur **:lobby**
- **lobby/1** doit verifier que le paramètre game est bien une map avec la clé **:status** à la valeur **:game_over**

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```

#### 4.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/4%20-%20Pattern%20Matching/correction).

[Correction Vidéo](https://youtu.be/VZTjw5qajIA)
