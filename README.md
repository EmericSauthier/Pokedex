# SAUTHIER EMERIC

# Avancement
## Partie 1
- Projet SwiftUI & Dépôt Github : OK
- Communication avec API : OK
- Struct Pokemon : OK
  
## Partie 2
- Récupérer de la liste de pokemons : OK
- Décoder la liste en JSON : OK
- Affichage des pokemons : OK
- CoreData : OK

## Partie 3
- Page de détail d'un pokemon : OK
- Barre de navigation  : OK
- Animations personnalisées : OK

## Partie 4
- Barre de recherche : OK
- Filtre par type : OK
- Tri : OK
- @State et onChange : OK

## Partie 5
- Animation à l'affichage d'une carte : OK

# Fonctionnalités
## Recherche :
Lorsque l'utilisateur rentre des caractères dans le champs de saisie, les pokémons dont le nom contient la chaîne de caractères sont affichés; les autres sont cachés. Si rien n'est saisi, tous les pokémons s'affichent.

## Filtres :
Il est possible de filtrer la liste de pokémons en fonction de leur type.
Il est également possible d'afficher uniquement les favoris.

## Tri alphabétique :
Il est possible de modifier l'ordre de tri de la liste. Ce tri s'effectue sur le nom des pokémons.

## Page de détail
Lorsque l'on clique sur un pokémon de la liste, l'utilisateur est redirigé sur une page de détail.
Lors de l'affichage de la carte pokémon, l'image s'anime et les informations s'affichent.
Les principales statistiques du pokémon sont affichées. Il est également possible d'ajouter ou de retirer le pokémon des favoris.

# Fonctionnement de l'application
L'application a été créée en s'inspirant de l'architecture MVVM.

## Dossier "Views"
Le dossier "Views" contient les deux pages de l'application : la page principale ("ContentView") et la page de détail ("PokemonDetail").

## Dossier "ViewModel"
Le dossier "ViewModel" contient le view model de l'application.
Le view model fait office d'intermédiaire entre l'api et les vues.

## Dossier "ApiService"
Le dossier "ApiService" contient la class "ApiService" qui se charge de questionner l'api et de sérialiser les données en objet.

## Dossier "Models"
Le dossier "Models" contient l'ensemble des structures qui reprénsentent des données (pokémon, type, stat).
La classe ApiService s'appuie sur ces classes pour sérialiser les données.

## Fichier "Persistence"
Le fichier "Persistence" permet de mettre en place la persistance des données et la sauvegarde de celles-ci dans le cache. Il est donc possible de consulter le pokédex sans connexion ou de garder sa liste de favoris.
Les données stockées dans le cache ont la forme suivantes :
- id -> Int64
- data -> String contenant l'ensemble des informations du pokémon