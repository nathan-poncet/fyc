# QCM Final
## Consignes
- Répondez à chaque question par la réponse qui vous semble la plus appropriée (une seule réponse par question).
- Regardez la correction et calculez votre score.
- Comparez votre score avec le tableau pour connaitre votre niveau en Elixir (chaque bonne réponse rapporte 1 point).

## Test
1. Quelle est la particularité d'Elixir par rapport à d'autres langages de programmation ?
- A) Syntaxe basée sur Ruby
- B) Compilation en bytecode Java
- C) Conçu pour la programmation fonctionnelle et concurrente
- D) Utilise la JVM pour l'exécution

2. Elixir est construit sur quelle machine virtuelle ?
- A) JVM
- B) Python VM
- C) BEAM
- D) CLR

3. Quel type de données utiliseriez-vous pour stocker une liste ordonnée d'éléments en Elixir ?
- A) Map
- B) Tuple
- C) List
- D) Atom

4. Comment définissez-vous un atome en Elixir ?
- A) `:atom`
- B) `@atom`
- C) `"atom"`
- D) `{atom}`

5. Quelle est la différence entre les chaînes de caractères et les listes de caractères en Elixir ?
- A) Aucune différence
- B) Les chaînes de caractères sont immutables
- C) Les listes de caractères utilisent la syntaxe de liste
- D) Les chaînes de caractères sont plus rapides pour l'accès séquentiel

6. Comment pouvez-vous définir une fonction anonyme en Elixir ?
- A) `def function() do end`
- B) `fn -> end`
- C) `lambda()`
- D) `function() {}`

7. Quel opérateur est utilisé pour le Pattern Matching en Elixir ?
- A) `=`
- B) `==`
- C) `:=`
- D) `=~`

8. À quoi sert l'opérateur |> en Elixir ?
- A) Concaténation de chaînes
- B) Opération mathématique
- C) Pipe (transfert) le résultat d'une fonction à une autre
- D) Comparaison

9. Quelle fonction du module Enum permet de transformer chaque élément d'une liste ?
- A) `Enum.each`
- B) `Enum.map`
- C) `Enum.filter`
- D) `Enum.reduce`

10. Comment gérer les erreurs avec try, catch, et raise en Elixir ?
- A) En les ignorant
- B) En utilisant des callbacks
- C) En les encapsulant dans des structures de contrôle spécifiques
- D) En les transmettant à une fonction externe

11. Qu'est-ce qu'un guard en Elixir ?
- A) Un type spécial de fonction pour générer des erreurs
- B) Une clause qui spécifie des conditions supplémentaires pour les clauses de fonction
- C) Un opérateur pour gérer les exceptions
- D) Un mécanisme de verrouillage pour la programmation concurrente

12. Comment effectuer un test de documentation dans Elixir ?
- A) En utilisant `@spec`
- B) Avec `@doc`
- C) En utilisant `ExUnit.Case`
- D) Avec `doctest`

13. Quelle est l'utilité des alias dans les modules Elixir ?
- A) Pour renommer les fonctions
- B) Pour créer des variables globales
- C) Pour référencer des modules par un nom plus court
- D) Pour définir des macros

14. Qu'est-ce qu'un GenServer en Elixir ?
- A) Un serveur générique pour la gestion d'état
- B) Un générateur de code source
- C) Une interface pour les serveurs web
- D) Un serveur pour les applications génétiques

15. Comment exécuter une tâche de manière asynchrone en Elixir ?
- A) En utilisant `Task.async`
- B) Avec `async/await`
- C) En utilisant des callbacks
- D) Avec `Process.spawn`

16. Quelle est la différence entre Enum.map et Enum.reduce ?
- A) `Enum.map` modifie chaque élément, `Enum.reduce` combine les éléments
- B) `Enum.map` pour la concurrence, `Enum.reduce` pour les itérations simples
- C) `Enum.map` exécute une fonction, `Enum.reduce` filtre les éléments
- D) Aucune différence, les deux sont interchangeables

17. Comment le pattern PubSub est-il utilisé en Elixir ?
- A) Pour la sérialisation des données
- B) Pour la communication inter-processus
- C) Pour le stockage persistant
- D) Pour l'authentification des utilisateurs

18. Quelle fonction du module Enum permet de filtrer une liste ?
- A) `Enum.filter`
- B) `Enum.map`
- C) `Enum.reduce`
- D) `Enum.each`

19. Comment définir plusieurs clauses pour une fonction en Elixir ?
- A) En utilisant des lambdas
- B) Avec des guards
- C) Par surcharge de la fonction
- D) Avec des callbacks

20. Quelle est l'utilité de l'opérateur & en Elixir ?
- A) Pour créer une référence à une fonction
- B) Pour la concaténation de chaînes
- C) Pour la gestion des erreurs
- D) Pour la comparaison d'atomes

21. Comment ignorer des valeurs lors du Pattern Matching en Elixir ?
- A) En utilisant `_`
- B) Avec `nil`
- C) En utilisant `ignore`
- D) Avec `pass`

22. Quel attribut utilisez-vous pour documenter un module en Elixir ?
- A) `@moduledoc`
- B) `@doc`
- C) `@comment`
- D) `@documentation`

23. Comment supervisez-vous des processus en Elixir ?
- A) Avec `Process.monitor`
- B) En utilisant `Supervisor.start_link`
- C) Par `GenServer.call`
- D) Avec `Task.async`

24. Qu'est-ce qu'un DynamicSupervisor ?
- A) Un superviseur pour les tâches dynamiques
- B) Un superviseur qui ajuste dynamiquement ses stratégies
- C) Un superviseur qui peut démarrer des enfants dynamiquement
- D) Un outil de surveillance de performance

25. Quelle est la principale utilisation des structs en Elixir ?
- A) Pour créer des types personnalisés avec des propriétés prédéfinies
- B) Comme synonyme des maps pour une meilleure performance
- C) Pour définir des fonctions anonymes
- D) Pour la gestion des erreurs et des exceptions

26. Comment déclarer un module en Elixir ?
- A) `module MyModule do end`
- B) `defmodule MyModule do end`
- C) `create MyModule do end`
- D) `module : MyModule`

27. À quoi sert `IO.puts` en Elixir ?
- A) Pour lire des entrées utilisateur
- B) Pour écrire dans un fichier
- C) Pour afficher un message dans la console
- D) Pour envoyer des données sur le réseau

28. Quel est le moyen de gérer l'état dans un GenServer ?
- A) À travers des variables d'instance
- B) En utilisant des maps globales
- C) En passant l'état à chaque appel de fonction
- D) En stockant l'état dans une base de données externe

29. Comment créer une liste de caractères en Elixir ?
- A) Avec des guillemets doubles ""
- B) Avec des guillemets simples ''
- C) En utilisant des crochets []
- D) Avec des accolades {}

30. Quel mécanisme Elixir permet de traiter plusieurs messages simultanément ?
- A) Task
- B) GenServer
- C) Process
- D) Agent

31. Quel est le rôle du fichier `mix.exs` dans un projet Elixir ?
- A) Configurer les dépendances et l'environnement de l'application
- B) Compiler le projet
- C) Exécuter des tests
- D) Gérer la base de données

32. Comment définir une fonction avec un nombre variable d'arguments en Elixir ?
- A) En utilisant des listes
- B) Avec des arguments par défaut
- C) En utilisant des macros
- D) Cette fonctionnalité n'existe pas en Elixir

33. Quelle est la commande pour créer un nouveau projet Elixir avec Mix ?
- A) `elixir new project_name`
- B) `mix new project_name`
- C) `mix create project_name`
- D) `elixir create project_name`

34. Qu'est-ce que l'OTP en Elixir ?
- A) Un protocole de transfert optimisé
- B) Un ensemble de modules et de comportements pour construire des applications distribuées
- C) Un générateur de mot de passe à usage unique
- D) Un outil de test de performance

35. Comment implémenter un comportement de callback en Elixir ?
- A) En utilisant le mot-clé `callback`
- B) Avec des hooks
- C) Par des modules de comportement et des spécifications `@callback`
- D) En définissant des fonctions anonymes

36. Quel est l'avantage d'utiliser le pattern Superviseur en Elixir ?
- A) Augmentation de la vitesse de traitement des données
- B) Amélioration de l'interface utilisateur
- C) Gestion de la reprise après une défaillance de processus
- D) Réduction de l'utilisation de la mémoire

37. Quelle est la syntaxe pour invoquer une fonction anonyme en Elixir ?
- A) `function.()`
- B) `function()`
- C) `function[]`
- D) `function{}`

38. Comment utiliser les variables d'environnement dans Elixir ?
- A) `System.get_env("VARIABLE")`
- B) `ENV["VARIABLE"]`
- C) `System.env("VARIABLE")`
- D) `Env.get("VARIABLE")`

39. Qu'est-ce qu'un comportement en Elixir?
- A) Une fonction spéciale pour le traitement des erreurs
- B) Un ensemble de fonctions définies dans un module que d'autres modules peuvent implémenter
- C) Une manière de structurer les données dans des tuples
- D) Un pattern de conception pour la programmation asynchrone

40. Comment lancer un processus léger en Elixir ?
- A) `Process.start()`
- B) `spawn(fn -> end)`
- C) `Thread.new()`
- D) `fork()`

## Correction

1. Quelle est la particularité d'Elixir par rapport à d'autres langages de programmation ? 
Réponse C) Conçu pour la programmation fonctionnelle et concurrente

2. Elixir est construit sur quelle machine virtuelle ?
Réponse C) BEAM

3. Quel type de données utiliseriez-vous pour stocker une liste ordonnée d'éléments en Elixir ?
Réponse C) List

4. Comment définissez-vous un atome en Elixir ?
Réponse A) `:atom`

5. Quelle est la différence entre les chaînes de caractères et les listes de caractères en Elixir ?
Réponse C) Les listes de caractères utilisent la syntaxe de liste

6. Comment pouvez-vous définir une fonction anonyme en Elixir ?
Réponse B) `fn -> end`

7. Quel opérateur est utilisé pour le Pattern Matching en Elixir ?
Réponse A) `=`

8. À quoi sert l'opérateur |> en Elixir ?
Réponse C) Pipe (transfert) le résultat d'une fonction à une autre

9. Quelle fonction du module Enum permet de transformer chaque élément d'une liste ?
Réponse B) `Enum.map`

10. Comment gérer les erreurs avec try, catch, et raise en Elixir ?
Réponse C) En les encapsulant dans des structures de contrôle spécifiques

11. Qu'est-ce qu'un guard en Elixir ?
Réponse B) Une clause qui spécifie des conditions supplémentaires pour les clauses de fonction

12. Comment effectuer un test de documentation dans Elixir ?
Réponse D) Avec `doctest`

13. Quelle est l'utilité des alias dans les modules Elixir ?
Réponse C) Pour référencer des modules par un nom plus court

14. Qu'est-ce qu'un GenServer en Elixir ?
Réponse A) Un serveur générique pour la gestion d'état

15. Comment exécuter une tâche de manière asynchrone en Elixir ?
Réponse A) En utilisant `Task.async`

16. Quelle est la différence entre Enum.map et Enum.reduce ?
Réponse A) `Enum.map` modifie chaque élément, `Enum.reduce` combine les éléments

17. Comment le pattern PubSub est-il utilisé en Elixir ?
Réponse B) Pour la communication inter-processus

18. Quelle fonction du module Enum permet de filtrer une liste ?
Réponse A) `Enum.filter`

19. Comment définir plusieurs clauses pour une fonction en Elixir ?
Réponse C) Par surcharge de la fonction

20. Quelle est l'utilité de l'opérateur & en Elixir ?
Réponse A) Pour créer une référence à une fonction

21. Comment ignorer des valeurs lors du Pattern Matching en Elixir ?
Réponse A) En utilisant `_`

22. Quel attribut utilisez-vous pour documenter un module en Elixir ?
Réponse A) `@moduledoc`

23. Comment supervisez-vous des processus en Elixir ?
Réponse B) En utilisant `Supervisor.start_link`

24. Qu'est-ce qu'un DynamicSupervisor ?
Réponse C) Un superviseur qui peut démarrer des enfants dynamiquement

25. Quelle est la principale utilisation des structs en Elixir ?
Réponse A) Pour créer des types personnalisés avec des propriétés prédéfinies

26. Comment déclarer un module en Elixir ?
Réponse B) `defmodule MyModule do end`

27. À quoi sert `IO.puts` en Elixir ?
Réponse C) Pour afficher un message dans la console

28. Quel est le moyen de gérer l'état dans un GenServer ?
Réponse C) En passant l'état à chaque appel de fonction

29. Comment créer une liste de caractères en Elixir ?
Réponse B) Avec des guillemets simples ''

30. Quel mécanisme Elixir permet de traiter plusieurs messages simultanément ?
Réponse C) Process

31. Quel est le rôle du fichier `mix.exs` dans un projet Elixir ?
Réponse A) Configurer les dépendances et l'environnement de l'application

32. Comment définir une fonction avec un nombre variable d'arguments en Elixir ?
Réponse D) Cette fonctionnalité n'existe pas en Elixir

33. Quelle est la commande pour créer un nouveau projet Elixir avec Mix ?
Réponse B) `mix new project_name`

34. Qu'est-ce que l'OTP en Elixir ?
Réponse B) Un ensemble de modules et de comportements pour construire des applications distribuées

35. Comment implémenter un comportement de callback en Elixir ?
Réponse C) Par des modules de comportement et des spécifications `@callback`

36. Quel est l'avantage d'utiliser le pattern Superviseur en Elixir ?
Réponse C) Gestion de la reprise après une défaillance de processus

37. Quelle est la syntaxe pour invoquer une fonction anonyme en Elixir ?
Réponse A) `function.()`

38. Comment utiliser les variables d'environnement dans Elixir ?
Réponse A) `System.get_env("VARIABLE")`

39. Qu'est-ce qu'un comportement en Elixir?
Réponse B) Un ensemble de fonctions définies dans un module que d'autres modules peuvent implémenter

40. Comment lancer un processus léger en Elixir ?
Réponse B) `spawn(fn -> end`

## Score
| Plage de Scores | Niveau en Elixir     | Description                                                                                                                                      |
|-----------------|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| 36 - 40         | Expert               | Vous avez une excellente maîtrise d'Elixir, incluant les concepts avancés et la programmation concurrente.                                       |
| 31 - 35         | Avancé               | Vous avez une bonne compréhension des fonctionnalités avancées d'Elixir et êtes capable de les utiliser efficacement dans des projets complexes. |
| 26 - 30         | Intermédiaire Avancé | Vous comprenez bien les concepts de base et certains concepts avancés, mais il peut vous rester quelques zones à approfondir.                    |
| 21 - 25         | Intermédiaire        | Vous avez une bonne compréhension des principes de base d'Elixir et êtes à l'aise avec la programmation fonctionnelle.                           |
| 16 - 20         | Débutant Avancé      | Vous avez une compréhension de base d'Elixir avec un besoin de renforcer vos connaissances sur des sujets plus complexes.                        |
| 0 - 15          | Débutant             | Vous êtes au début de votre apprentissage d'Elixir et il est recommandé de revoir les concepts fondamentaux et de pratiquer davantage.           |
