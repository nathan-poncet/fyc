## 2 Types de base
### 2.1 Cours
Elixir, comme tout langage de programmation, possède une variété de types de base qui constituent les blocs de construction des programmes. Dans cette section, nous allons explorer ces types de base.
#### 2.1.1 Nombres
Elixir gère les entiers et les nombres à virgule.
```elixir
# Entier
a = 3

# Nombre à virgule flottante
b = 4.5

# Opération arithmétique
c = a + b  # Résultat: 7.5
```
#### 2.1.2 Atomes
Les atomes sont des constantes où le nom est la valeur.  Les atomes sont souvent utilisés comme étiquettes dans Elixir, notamment dans les tuples.
```elixir
:mon_atome
:success

# utilise l'atome :ok pour indiquer le succès d'une opération dans un tuple.
{:ok, resultat}
```

#### 2.1.3 Chaînes de Caractères
Les chaînes de caractères sont encodées en UTF-8.
```elixir
ma_chaine = "Bonjour le monde"

# Concaténation
message = "Bonjour " <> "monde"
```

#### 2.1.4 Listes
Les listes peuvent contenir des éléments de différents types.
```elixir
ma_liste = [1, 2, 3, :quatre, "cinq"]

# Acceder à un élément par son index
troisieme_element = Enum.at(ma_liste, 2)  # Résultat: 3

# Ajouter l'élément à la fin de la liste
nouvel_element = 6
ma_liste = ma_liste ++ [nouvel_element]
```

#### 2.1.5 Tuples
Les tuples regroupent un nombre fixe d'éléments.
```elixir
mon_tuple = {1, 2, 3}

# Accès à un élément du tuple
element = elem(mon_tuple, 1)  # Résultat: 2
```

#### 2.1.6 Maps
Les maps sont des collections clé-valeur.
```elixir
ma_map = %{"clef" => "valeur", :autre_clef => 123}
# Accès à une valeur
valeur = ma_map["clef"]  # Résultat: "valeur"
```

#### 2.1.7 Binaires et Chaînes de Caractères
Les chaînes de caractères sont des binaires UTF-8.
```elixir
# 'hello' en ASCII
binaire = <<104, 101, 108, 108, 111>> 
```

#### 2.1.8 Listes de Caractères
Les listes de caractères sont essentiellement des listes d'entiers où chaque entier représente un point de code Unicode.
```elixir
# Liste de caractères [101, 108, 105, 120, 105, 114]
liste = 'elixir' 
```

#### 2.1.9 Documentation officiel
- [Types de base](https://hexdocs.pm/elixir/1.16/basic-types.html)
- [Binaires et Chaînes de Caractères](https://hexdocs.pm/elixir/1.16/binaries-strings-and-charlists.html)