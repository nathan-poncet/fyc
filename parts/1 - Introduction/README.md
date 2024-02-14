# Formation Elixir
## 1 Introduction
[Vidéo présentation](https://www.youtube.com/watch?v=QOgnYvwCM1c)

Bienvenue dans l'univers captivant d'Elixir !

Imaginez un monde où la concurrence n'est pas une source de maux de tête, mais plutôt un doux rêve. Un monde où les erreurs ne font pas s'effondrer des systèmes entiers, mais sont accueillies, gérées et apprivoisées. Un monde où le code est fluide, intuitif et joyeux à écrire. Ce monde, chers apprenants, c'est celui d'Elixir !

Elixir n'est pas seulement un autre langage de programmation; c'est une invitation à repenser comment nous abordons la programmation dans son ensemble. Inspiré de la beauté fonctionnelle d'Erlang et doté d'une touche moderne, Elixir nous promet de faire de la programmation une expérience à la fois puissante et agréable.

Alors que nous entamons ce voyage ensemble, nous ne nous contenterons pas de "coder". Nous allons tisser des récits, résoudre des énigmes et construire, pièce par pièce, un puissance 4 multijoueur - le tout sans s'appuyer lourdement sur les frameworks conventionnels. À chaque étape, nous plongerons profondément dans ce qui rend Elixir unique, et comment nous pouvons exploiter sa puissance pour nos besoins.

Peut-être êtes-vous ici parce que vous avez entendu parler de la magie de la plateforme OTP, ou peut-être que vous êtes simplement curieux de voir à quoi ressemble le monde au-delà des langages de programmation conventionnels. Quelle que soit la raison, nous sommes ravis de vous avoir à bord.

Accrochez-vous, car nous sommes sur le point d'entamer une aventure éducative inoubliable !

Avant de commencer cette formation, il est conseillé de réaliser [ce test de positionnement](https://github.com/nathan-poncet/fyc/tree/main/parts/1%20-%20Introduction/tp/test.md) pour savoir si vous êtes prêt à entamer cette formation.

### 1.1 Histoire
#### 1.1.1 Les Premiers Échos de Frustration
Derrière chaque grande invention se trouve souvent une certaine frustration. Pour José Valim, ce sentiment est né au sein de la communauté Ruby on Rails. En tant que contributeur éminent, il a rencontré des défis persistants autour de la concurrence et du parallélisme. Malgré les atouts de Ruby, les limites en termes de performance et d'évolutivité devenaient de plus en plus visibles.

#### 1.1.2 La Découverte d'Erlang
En cherchant des solutions, Valim a découvert Erlang, une vieille langue née au cœur d'Ericsson pour gérer des systèmes télécoms ultra-fiables. Sa machine virtuelle, BEAM, a été une révélation. Avec des promesses de concurrence sans faille, de tolérance aux défaillances et de distribution facile, BEAM avait tout ce que Ruby ne pouvait offrir. Cependant, il y avait encore place à l'amélioration, surtout en ce qui concerne la métaprogrammation, l'outillage et la facilité d'utilisation.

#### 1.1.3 La Conception d'Elixir
Motivé par cette opportunité, Valim a commencé à travailler sur Elixir. Ce langage combinait la robustesse d'Erlang avec la métaprogrammation avancée et une syntaxe améliorée. Elixir n'était pas simplement un vernis moderne sur Erlang, mais un véritable effort pour repousser les frontières de ce qui était possible avec la BEAM. De plus, Elixir introduisait de nouveaux protocoles, un système macro puissant et un outillage de pointe, notamment avec l'introduction de Mix (outil de création et gestion de projet) et Hex (le gestionnaire de paquets d'Elixir).

#### 1.1.4 La Croissance et l'Adoption
La première version d'Elixir a été dévoilée en 2011. Les premières réactions étaient mitigées, mais la vision de Valim était claire. Grâce à des améliorations continues et à la force de la communauté naissante, Elixir a commencé à gagner en traction. Des entreprises de pointe comme Discord, Pinterest et Bleacher Report ont vu les avantages d'Elixir pour les systèmes à grande échelle et ont décidé d'investir. Le framework Phoenix, basé sur Elixir, a également émergé, offrant des capacités web modernes tout en exploitant pleinement la concurrence d'Erlang. 

#### 1.1.5 Elixir Aujourd'hui
Elixir a évolué pour devenir bien plus qu'une simple alternative à Erlang. C'est maintenant un écosystème en pleine expansion avec une communauté active et dévouée. Les bibliothèques et les frameworks basés sur Elixir ne cessent de croître, démontrant la flexibilité et la puissance du langage. Actuellement, nous sommes en version 1.16 d'Elixir, et ce cours se base cette version.

#### 1.1.6 Conclusion :
L'histoire d'Elixir est celle de l'innovation et de l'adaptation. En puisant dans le passé tout en regardant vers l'avenir, Elixir est devenu un pilier de la programmation moderne. C'est une leçon sur la manière dont une vision claire, couplée à la détermination, peut aboutir à une transformation profonde dans le monde de la technologie. 

### 1.2 Suis-je prêt pour Elixir ?
TEST DE POSITIONNEMENT

### 1.3 Installation  d’elixir & différent modes d’executions
> **Objectifs :**
> - Installer Elixir sur votre machine
> - Exécuter un script Elixir de base
> - Comprendre les différents modes d'exécution d'un script Elixir

#### 1.3.1 Installation d'Elixir
Elixir est un langage de programmation dynamique, fonctionnel conçu pour créer des applications évolutives et maintenables. Pour commencer à l'utiliser, vous devez l'installer sur votre ordinateur.

Pour les utilisateurs de macOS
- Ouvrez votre terminal.
- Installez Homebrew si vous ne l'avez pas déjà : `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Mettez à jour Homebrew : `brew update`
- Installez Elixir : `brew install elixir`

Pour les utilisateurs de Windows
- Visitez le [site officiel d'Elixir](https://elixir-lang.org/install.html#windows)
- Suivez les instructions pour télécharger et installer le package pour Windows

Pour les utilisateurs de Linux
- La méthode varie selon la distribution que vous utilisez. Veuillez consulter le [guide officiel](https://elixir-lang.org/install.html#unix-and-unix-like) pour votre distribution spécifique

### 1.3.2 Exécution d'un script Elixir
Créez un fichier nommé **hello_world.exs** et insérez le code suivant :

```elixir
IO.puts "Hello, world!"
```
Pour exécuter le script, ouvrez votre terminal, naviguez vers le dossier où se trouve le fichier et tapez :

```bash
elixir hello_world.exs
```

Vous devriez voir s'afficher : Hello, world!

### 1.3.3 Comprendre les modes d'exécution
Lors de l'installation d'Elixir, vous avez accès à trois nouveaux exécutables, essentiels à la maîtrise du langage. Ces outils sont la clé pour tirer pleinement parti de ce que le langage Elixir a à offrir.

**Iex - Interactive Elixir :**
IEx, pour Interactive Elixir, est le shell interactif d'Elixir. Il fonctionne comme un REPL (Read-Eval-Print Loop), permettant d'écrire et d'exécuter du code Elixir en temps réel.
Il est idéal pour l'apprentissage, tester des morceaux de code, et le débogage.

Ouvrez votre terminal, tapez simplement `iex`, et commencez à écrire du code Elixir.
```elixir
IO.puts "Salut depuis IEx !"
```

**Elixir - L'Interpréteur Elixir :**
C'est le mode que nous avons utilisé précédemment.
Cet exécutable est utilisé pour faire tourner des scripts .exs. Il est conçu pour exécuter rapidement des programmes Elixir sans avoir à les compiler au préalable.
Il est idéal pour l'exécution de scripts, tâches de fond, et petits programmes.

Pour exécuter un script, ouvrez votre terminal et tapez elixir <nom_du_fichier>.exs.

**Elixirc - Le Compilateur Elixir :**
Elixirc est le compilateur Elixir. Il compile les fichiers **.ex** en bytecode pour la BEAM (machine virtuelle Erlang), produisant des fichiers .beam.
il est utilisé pour compiler des modules et des projets plus grands, pour une exécution plus rapide et une distribution du code.

Pour compiler un fichier, ouvrez votre terminal et tapez `elixirc <nom_du_fichier>.ex`.

**Conclusion :**
Félicitations ! Vous avez installé Elixir, exécuté votre premier script, et découvert les différents modes d'exécution d'Elixir. Dans les prochaines sessions, nous plongerons plus profondément dans la beauté et la puissance d'Elixir.
