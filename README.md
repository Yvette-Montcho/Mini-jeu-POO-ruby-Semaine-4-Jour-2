# Mini jeu POO 
## Présentation du projet

Ce projet a été réalisé dans le cadre d’un apprentissage de la **Programmation Orientée Objet (POO) en Ruby**.
L’objectif est de construire progressivement un mini jeu de combat en console, en appliquant les notions fondamentales de la POO :

* création de classes ;
* création d’objets (instances) ;
* utilisation d’attributs et de méthodes ;
* héritage entre classes ;
* composition d’objets ;
* organisation du code dans plusieurs fichiers.

Le jeu proposé est un **mini jeu de combat inspiré de Fortnite**, mais en version très simplifiée et jouable dans le terminal. Le joueur humain affronte plusieurs ennemis jusqu’à ce qu’il soit éliminé ou qu’il devienne le dernier survivant.

---

## Objectifs pédagogiques

Ce projet ne consiste pas seulement à produire un jeu fonctionnel. Il permet surtout de mettre en pratique plusieurs notions essentielles de Ruby et de la POO :

### 1. Modéliser des entités avec des classes

Le projet introduit une classe `Player` représentant un joueur standard, avec :

* un nom ;
* un nombre de points de vie ;
* la capacité d’attaquer et de subir des dégâts.

### 2. Utiliser l’héritage

Une seconde classe, `HumanPlayer`, hérite de `Player`.
Elle reprend donc le comportement de base d’un joueur, mais possède des caractéristiques supplémentaires :

* plus de points de vie ;
* une arme de niveau variable ;
* la possibilité de chercher une meilleure arme ;
* la possibilité de chercher des packs de soin.

### 3. Structurer un programme orienté objet

Dans la version 3.0, la logique globale du jeu n’est plus écrite directement dans le fichier principal. Elle est déplacée dans une classe `Game`, ce qui permet de :

* centraliser les données du jeu ;
* mieux organiser les responsabilités ;
* rendre le code plus lisible et plus maintenable.

### 4. Produire plusieurs versions d’un même programme

Le projet est découpé en **trois versions successives**, permettant de montrer une progression :

* version 1.0 : combat entre deux joueurs ;
* version 2.0 : ajout d’un joueur humain et d’actions spéciales ;
* version 3.0 : introduction d’une classe `Game` et d’un système d’ennemis évolutif.

---

## Architecture du projet

Le projet est organisé de la manière suivante :

```text
jeu_POO/
├── lib/
│   ├── player.rb
│   └── game.rb
├── app.rb
├── app_2.rb
├── app_3.rb
├── Gemfile
└── README.md
```

### Description des fichiers

#### `lib/player.rb`

Ce fichier contient les classes :

* `Player` : joueur classique ;
* `HumanPlayer` : joueur humain, héritant de `Player`.

#### `lib/game.rb`

Ce fichier contient la classe `Game`, chargée de gérer la logique générale du jeu dans la version 3.0.

#### `app.rb`

Ce fichier correspond à la **version 1.0** du projet.
Il permet de lancer un combat simple entre deux joueurs classiques.

#### `app_2.rb`

Ce fichier correspond à la **version 2.0** du projet.
Il permet au joueur humain d’interagir avec le jeu grâce à un menu d’actions.

#### `app_3.rb`

Ce fichier correspond à la **version 3.0** du projet.
La gestion du jeu est déléguée à la classe `Game`, ce qui rend l’application mieux structurée.

#### `Gemfile`

Ce fichier contient les dépendances Ruby nécessaires au projet. Ici, la gem `pry` est utilisée pour faciliter les tests et le débogage.

#### `README.md`

Ce document explique le fonctionnement du projet, son organisation et les notions techniques mobilisées.

---

## Fonctionnement général du jeu

Le principe du jeu est simple :

* un joueur humain entre son prénom ;
* il affronte des ennemis dans une arène ;
* à chaque tour, il peut choisir une action ;
* les ennemis ripostent s’ils sont encore en vie ;
* la partie se termine lorsque le joueur humain meurt ou qu’il n’y a plus d’ennemis à battre.

Le jeu se déroule dans le terminal, avec un affichage textuel de l’état des joueurs et des actions effectuées.

---

## Détail des versions

## Version 1.0 — Combat simple entre deux joueurs

La première version a pour but de poser les bases du projet.

### Fonctionnalités

* création de deux objets `Player` ;
* affichage de leur état ;
* attaque d’un joueur sur l’autre ;
* perte de points de vie ;
* arrêt du combat lorsqu’un joueur meurt.

### Notions mobilisées

* classe ;
* attributs ;
* méthode `initialize` ;
* méthodes d’instance ;
* boucle `while` ;
* condition d’arrêt.

### But pédagogique

Cette version permet de comprendre comment modéliser un objet simple et comment lui associer des comportements.

---

## Version 2.0 — Ajout d’un joueur humain

La deuxième version enrichit le jeu en introduisant une nouvelle classe : `HumanPlayer`.

### Nouvelles fonctionnalités

* le joueur humain commence avec 100 points de vie ;
* il possède une arme avec un niveau ;
* il peut chercher une meilleure arme ;
* il peut chercher un pack de soin ;
* il choisit ses actions via un menu interactif ;
* les ennemis ripostent à chaque tour.

### Notions mobilisées

* héritage ;
* redéfinition de méthodes ;
* spécialisation d’une classe fille ;
* interaction avec l’utilisateur via `gets.chomp`.

### But pédagogique

Cette version montre l’intérêt de l’héritage : un objet `HumanPlayer` est un joueur, mais avec plus de possibilités qu’un `Player` classique.

---

## Version 3.0 — Classe `Game` et meilleure organisation

La troisième version améliore l’architecture du projet.

### Nouvelles fonctionnalités

* création d’une classe `Game` ;
* centralisation de la logique du jeu ;
* gestion d’un nombre plus important d’ennemis ;
* arrivée progressive des ennemis dans le champ de vision ;
* séparation plus nette entre les rôles des fichiers.

### Attributs principaux de `Game`

* `@human_player` : le joueur contrôlé par l’utilisateur ;
* `@players_left` : nombre total d’ennemis restant à éliminer ;
* `@enemies_in_sight` : liste des ennemis actuellement visibles.

### Méthodes principales de `Game`

* `is_still_ongoing?` : indique si la partie continue ;
* `show_players` : affiche l’état du joueur humain et le nombre d’ennemis restants ;
* `menu` : affiche les actions possibles ;
* `menu_choice` : exécute l’action choisie ;
* `enemies_attack` : gère la riposte des ennemis ;
* `new_players_in_sight` : fait apparaître de nouveaux ennemis ;
* `kill_player` : retire un ennemi mort du jeu visible ;
* `end_game` : affiche le résultat final.

### But pédagogique

Cette version permet de comprendre qu’un projet orienté objet doit être organisé autour de responsabilités claires.
Le fichier principal ne doit pas tout faire : il doit simplement orchestrer l’exécution du programme.

---

## Description des classes

## Classe `Player`

La classe `Player` représente un joueur standard.

### Attributs

* `name` : nom du joueur ;
* `life_points` : points de vie du joueur.

### Méthodes principales

* `initialize(name)` : crée un joueur avec 10 points de vie ;
* `show_state` : affiche l’état du joueur ;
* `gets_damage(damage)` : retire des points de vie ;
* `attacks(other_player)` : attaque un autre joueur ;
* `compute_damage` : calcule un nombre aléatoire de dégâts entre 1 et 6.

---

## Classe `HumanPlayer`

La classe `HumanPlayer` hérite de `Player`.

### Particularités

* elle commence avec 100 points de vie ;
* elle possède un attribut supplémentaire : `weapon_level`.

### Méthodes spécifiques

* `show_state` : affiche la vie et le niveau d’arme ;
* `compute_damage` : multiplie les dégâts par le niveau de l’arme ;
* `search_weapon` : cherche une nouvelle arme ;
* `search_health_pack` : cherche un pack de soin.

---

## Classe `Game`

La classe `Game` représente une partie complète.

### Rôle

Elle stocke les informations globales du jeu et gère les différentes étapes de la partie.

### Intérêt

Cette classe rend le code :

* plus clair ;
* plus modulaire ;
* plus facile à faire évoluer.

---

## Choix techniques et remarques

### 1. Utilisation de l’héritage

Le choix de faire hériter `HumanPlayer` de `Player` permet d’éviter la duplication de code.
Le joueur humain conserve toutes les capacités de base d’un joueur normal, tout en ajoutant ses propres fonctionnalités.

### 2. Méthode `compute_damage`

La méthode `compute_damage` a été isolée afin de pouvoir être redéfinie proprement dans la classe `HumanPlayer`. Cela évite de réécrire complètement la méthode `attacks`.

### 3. Gestion des ennemis avec des tableaux

Dans les versions 2.0 et 3.0, les ennemis sont stockés dans des tableaux (`enemies` ou `@enemies_in_sight`). Cela permet de les parcourir facilement avec des boucles, ce qui rend le programme extensible.

### 4. Nom de méthode `end_game`

Dans les consignes, une méthode `end` est suggérée pour afficher la fin de partie.
Cependant, `end` est un mot-clé réservé en Ruby. Pour éviter une erreur de syntaxe, cette méthode a été nommée `end_game`.

---

## Installation et exécution

## Prérequis

* avoir Ruby installé sur sa machine ;
* avoir Bundler installé.

## Installation

Dans le dossier du projet, exécuter :

```bash
bundle install
```

## Lancer les différentes versions

### Version 1.0

```bash
ruby app.rb
```

### Version 2.0

```bash
ruby app_2.rb
```

### Version 3.0

```bash
ruby app_3.rb
```

---

## Exemple de déroulement

### Exemple en version 1.0

* création de deux joueurs ;
* chaque joueur attaque à tour de rôle ;
* la boucle s’arrête dès qu’un joueur meurt.

### Exemple en version 2.0

* le joueur entre son prénom ;
* le menu propose de chercher une arme, se soigner ou attaquer ;
* les ennemis ripostent après l’action du joueur.

### Exemple en version 3.0

* le joueur humain est créé dans un objet `Game` ;
* de nouveaux ennemis apparaissent progressivement ;
* le jeu continue tant que le joueur est vivant et qu’il reste des ennemis à battre.

---

## Compétences travaillées

Ce projet permet de démontrer les compétences suivantes :

* écrire une classe en Ruby ;
* instancier des objets ;
* utiliser des attributs et des méthodes ;
* comprendre et exploiter l’héritage ;
* organiser un projet en plusieurs fichiers ;
* manipuler des tableaux d’objets ;
* structurer une logique de jeu orientée objet ;
* interagir avec l’utilisateur dans le terminal.

---

## Pistes d’amélioration

Plusieurs améliorations pourraient être ajoutées par la suite :

* afficher les combats avec davantage de mise en forme ;
* ajouter plusieurs types d’ennemis ;
* créer différents niveaux de difficulté ;
* ajouter un système de score ;
* permettre au joueur de choisir plusieurs actions avancées ;
* sauvegarder une partie ;
* mieux séparer encore les responsabilités entre les classes.

---

## Conclusion

Ce projet montre une progression complète dans l’apprentissage de la Programmation Orientée Objet en Ruby.
Il commence par une modélisation simple de joueurs et aboutit à une architecture plus propre avec une classe `Game` dédiée à la gestion d’une partie complète.

Au-delà de l’aspect ludique, ce travail met surtout en évidence :

* l’importance de structurer le code ;
* l’intérêt de l’héritage pour éviter la duplication ;
* la puissance des objets pour organiser les données et les comportements.

Ce projet constitue donc une bonne introduction pratique à la POO en Ruby.

---

## Auteur

Projet réalisé dans le cadre d’un exercice de Programmation Orientée Objet en Ruby.
Formation Fullstack Web avec ETP4Africa

