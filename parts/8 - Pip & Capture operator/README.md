## 8 Pipe Operator (|>) & Capture Operator
### 8.1 Cours
#### 8.1.1 Pipe Operator (|>)
Le Pipe Operator, représenté par le symbole **|>**, est l'un des concepts les plus puissants et caractéristiques d'Elixir. Il permet de composer des opérations de manière fluide et lisible en transférant le résultat d'une expression comme premier argument de la suivante. Le pipe operator facilite la création de chaînes de transformations de données.

```elixir
# Sans Pipe Operator
resultat1 = Enum.map([1, 2, 3], fn x -> x * 2 end)
resultat2 = Enum.filter(resultat1, fn x -> rem(x, 3) == 0 end)

# Avec Pipe Operator
resultat_final = [1, 2, 3]
  |> Enum.map(fn x -> x * 2 end)
  |> Enum.filter(fn x -> rem(x, 3) == 0 end)
```
Dans cet exemple, le résultat de chaque étape est passé comme premier argument à la fonction suivante à l'aide du Pipe Operator. Cela permet de composer des opérations de manière plus lisible.

#### 8.1.2 Capture Operator (&)
Le Capture Operator, représenté par le symbole **&**, est utilisé pour créer des fonctions anonymes de manière concise en capturant des fonctions existantes ou en définissant de nouvelles fonctions. Il est souvent utilisé avec le Pipe Operator pour transformer les données de manière fonctionnelle.
```elixir
# Définition d'une fonction anonyme avec Capture Operator
double = &(&1 * 2)

# Utilisation du Pipe Operator avec la fonction anonyme
resultat_final = [1, 2, 3]
  |> Enum.map(double)
  |> Enum.filter(fn x -> rem(x, 3) == 0 end)
```
Dans cet exemple, la fonction anonyme double est définie en utilisant le Capture Operator, ce qui permet de créer une fonction qui double son argument. Ensuite, cette fonction est utilisée avec le Pipe Operator pour transformer la liste de manière fonctionnelle.
#### 8.1.3 Documentation officiel
- [Pipe Operator](https://hexdocs.pm/elixir/1.16/enumerable-and-streams.html#the-pipe-operator)
- [Capture Operator](https://hexdocs.pm/elixir/1.16/anonymous-functions.html#the-capture-operator)

### 8.2 TP

#### 8.2.1 Objectifs

Repartez du dossier [tp](https://github.com/nathan-poncet/fyc/tree/main/parts/8%20-%20Pip%20&%20Capture%20operator/tp) et complétez le fichier **game.ex**:
- Modifiez la fonction **move/3** pour vérifier à chaque tour si un joueur a gagné ou si le tableau de jeu est plein. Pour ce faire, créez 2 nouvelles fonctions : 
  - board_win/3 -> Vérifie si un joueur a gagné
  - board_is_full/1 -> Vérifie si le tableau de jeu est plein
- Il y a beaucoup d'opération de transformation de données dans les nouvelles fonctions à créer. 
  - Utilisez le Pipe Operator pour rendre des suites d'opérations le code plus lisible.
  - Utilisez le Capture Operator pour créer des fonctions anonymes plus lisible.

Afin de vérifier que le travail est bien réalisé, validez les tests unitaires avec :

```bash
mix test
```
#### 8.2.2 Correction

La correction du projet se trouve [ici](https://github.com/nathan-poncet/fyc/tree/main/parts/8%20-%20Pip%20&%20Capture%20operator/correction).