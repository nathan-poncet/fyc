## 11 Les Erreurs

### 11.1 Cours

En Elixir, la gestion des erreurs est gérée différemment par rapport à certains autres langages. Plutôt que d'utiliser des exceptions pour signaler les erreurs, Elixir préfère renvoyer des tuples pour indiquer le succès ou l'échec d'une opération.

#### 11.1.1 Gestion des Erreurs avec try, catch, et raise

Vous pouvez utiliser la construction **try**, **catch**, et **raise** pour gérer les erreurs de manière plus explicite.

```elixir
try do
  File.read!("non_existent_file.txt")
catch
  :error, reason -> IO.puts("Error: #{reason}")
end
```

Dans cet exemple, nous essayons de lire un fichier qui n'existe pas. Si une exception est levée, elle est capturée par la clause catch, et le message d'erreur est affiché. Cela permet une gestion plus précise des erreurs lorsqu'on sait qu'une exception peut être levée.

#### 11.1.2 Renvoyer des Tuples pour indiquer le résultat

Il est courant de renvoyer des tuples pour indiquer si une opération a réussi ou échoué. Le tuple a généralement deux éléments :

- la clé **:ok** pour indiquer le succès
- la clé **:error** pour indiquer une erreur

Le deuxième élément du tuple peut contenir des informations supplémentaires sur l'erreur.

```elixir
{:ok, result} = File.read("myfile.txt")
```

Dans cet exemple, **File.read/1** renvoie un tuple **{:ok, result}** si la lecture du fichier réussit, où result contient le contenu du fichier. Si la lecture échoue, elle renvoie un tuple **{:error, reason}** où reason contient des informations sur l'erreur.

#### 11.1.3 La Laisse Cracher le Process (Let It Crash)

Un concept clé en Elixir est la philosophie de "laisser cracher le process" (let it crash). Au lieu d'essayer de gérer toutes les erreurs de manière exhaustive, Elixir encourage la création de processus légers qui peuvent être laissés à leur sort en cas d'erreur. Si un processus échoue en raison d'une erreur, il peut simplement être redémarré.

#### 11.1.4 Utilisation du Point d'Exclamation (!)

En Elixir, vous verrez parfois un point d'exclamation (!) à la fin de certaines fonctions. Cela indique que la fonction peut lever une exception en cas d'erreur au lieu de renvoyer un tuple d'erreur. Par exemple, **File.read!/1** lèvera une exception s'il ne peut pas lire le fichier, au lieu de renvoyer un tuple d'erreur.

Il est recommandé d'utiliser les versions sans point d'exclamation (File.read/1) chaque fois que possible, sauf si vous avez une raison spécifique de vouloir lever une exception en cas d'erreur.

```elixir
defmodule Math do
  def divide(a, b) do
    if b == 0 do
      raise "Division by zero is not allowed!"
    else
      a / b
    end
  end

  def divide!(a, b) do
    if b == 0 do
      raise "Division by zero is not allowed!"
    else
      a / b
    end
  end
end
```

Dans cet exemple, nous avons défini deux fonctions **divide/2** et **divide!/2** pour effectuer une division. Cependant, la version avec le point d'exclamation **divide!/2** lèvera une exception si la division par zéro est tentée, tandis que la version sans point d'exclamation (divide/2) renverra simplement un résultat non valide **NaN** sans lever d'exception.

```elixir
# Utilisation de la version sans point d'exclamation
result1 = Math.divide(10, 2)  # Résultat: 5.0 (division valide)
result2 = Math.divide(10, 0)  # Résultat: NaN (division par zéro)

# Utilisation de la version avec point d'exclamation
result3 = Math.divide!(10, 2)  # Résultat: 5.0 (division valide)
# La ligne suivante lèvera une exception
# result4 = Math.divide!(10, 0)  # Lève une exception en raison de la division par zéro
```

#### 11.1.5 Documentation officiel

- [TryCatch et Rescue](https://hexdocs.pm/elixir/1.16/try-catch-and-rescue.html)

### 11.2 TP

#### 11.2.1 Objectifs
Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/11%20-%20Error/tp) et implémentez une gestion des erreurs :
- Modifiez la fonctions**start/1** du fichier **game.ex** :
  - Gérez le cas oû la game n'a pas le statut **lobby**
- Modifiez la fonction **join/2** du fichier **game.ex** :
  - Gérez le cas oû le **player_id** est déja **utilisé**
  - Gérez le cas oû le **symbol** est déja utilisé
- Modifiez la fonction **lobby/1** du fichier **game.ex** :
  - Gérez le cas oû la game n'a pas le statut **game_over**
- Modifiez la fonction **move/3** du fichier **game.ex** :
  - Utilisez les guards
  - Gérez le cas oû la game n'a pas le statut **playing**
  - Gérez le cas oû **player** est vide 
  - Gérez le cas oû ce n'est pas à l'utilisateur de jouer
  - Gérez le cas oû la colonne n'existe pas
  - Gérez le cas oû la colonne est pleine
  
Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :
```bash
mix test
```
#### 11.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/11%20-%20Error/correction).
