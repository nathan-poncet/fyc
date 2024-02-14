## 6 Function clause

### 6.1 Cours

En Elixir, les fonctions peuvent avoir plusieurs clauses, ce qui signifie qu'une fonction peut avoir différents comportements en fonction des arguments qu'elle reçoit. Les clauses de fonction permettent de créer des fonctions polymorphes qui agissent différemment en fonction des conditions spécifiées.

#### 6.1.1 Définition de Fonctions avec Clauses Multiples

Pour définir une fonction avec plusieurs clauses, vous pouvez utiliser le mot-clé **def** suivi du nom de la fonction, puis spécifier chaque clause de la fonction en utilisant **do**. Chaque clause doit déterminer si elle doit être exécutée en fonction des arguments passés.

Voici un exemple qui illustre la définition d'une fonction **zero?/1** qui détermine si un nombre est égal à zéro :

```elixir
defmodule Math do
  # Première clause, vérifie si l'argument est égal à zéro
  def zero?(0) do
    true
  end

  # Deuxième clause, traitement par défaut
  def zero?(_) do
    false
  end
end
```

Dans cet exemple, la fonction **zero?/1** a deux clauses. La première clause renverra true si l'argument est égal à zéro, sinon elle ne sera pas exécutée. La deuxième clause sera exécutée par défaut si aucune autre clause ne correspond.

L'utilisation du caractère **?** à la fin du nom d'une fonction est une convention de nommage qui indique que la fonction est destinée à retourner un booléen.

#### 6.1.2 Utilisation de Clauses de Fonction

L'utilisation de clauses de fonction est courante en Elixir pour gérer des cas spécifiques en fonction des arguments passés à une fonction. Lorsqu'une fonction est appelée, Elixir évalue chaque clause dans l'ordre où elles sont définies, en recherchant la première clause qui correspond à l'argument. La clause correspondante est alors exécutée, et les autres clauses ne sont pas évaluées.

```shell
Math.zero?(0)    # Résultat: true
Math.zero?(5)    # Résultat: false
Math.zero?("Hello")  # Résultat: false (traitement par défaut)
```

#### 6.1.3 Signature de Fonction Différente

Les clauses de fonction permettent de définir différentes signatures pour la même fonction, ce qui améliore la lisibilité du code et permet de gérer plusieurs cas sans avoir à écrire des fonctions distinctes.

#### 6.1.4 Documentation officiel

- [Définition de fonction](https://hexdocs.pm/elixir/1.16/modules-and-functions.html#function-definition)

### 6.2 TP

#### 6.2.1 Objectifs
Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/6%20-%20Function%20Clause/tp) et complétez le fichier **game.ex**:
- Réalisez un easter egg, si l'utilisateur appel la fonction privée **board_generate/2** avec les paramètres (42, 42), la fonction retourne un tableau avec un nombre aléatoire de lignes/colonnes composées entre 1 et 20.
- À chaque fois qu'un utilisateur souhaite rejoindre la partie, vérifiez que l'id et le symbole utilisé sont disponibles.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec:

```bash
mix test
```

#### 6.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/6%20-%20Function%20Clause/correction).

[Correction Vidéo](https://youtu.be/CmIExuKCKzA)