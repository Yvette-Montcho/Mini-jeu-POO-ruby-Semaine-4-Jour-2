require_relative "lib/game" # On charge le fichier game.rb.
require_relative "lib/player" # On charge le fichier player.rb.

puts "-------------------------------------------------" # On affiche la première ligne du message d'accueil.
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |" # On affiche le titre du jeu.
puts "|Le but du jeu est d'être le dernier survivant !|" # On affiche l'objectif du jeu.
puts "-------------------------------------------------" # On affiche la dernière ligne du message d'accueil.
puts # On ajoute une ligne vide.

print "Quel est ton prénom ? " # On demande à l'utilisateur son prénom.
user_name = gets.chomp # On récupère le prénom saisi par l'utilisateur.

my_game = Game.new(user_name) # On crée une nouvelle partie en utilisant le prénom du joueur humain.

while my_game.is_still_ongoing? # On continue la boucle tant que la partie n'est pas terminée.
  puts # On ajoute une ligne vide.
  puts "=========================================" # On affiche une ligne de séparation pour chaque tour.
  puts # On ajoute une ligne vide.

  my_game.show_players # On affiche l'état du joueur humain et les informations globales sur les ennemis.
  puts # On ajoute une ligne vide.

  my_game.new_players_in_sight # On fait éventuellement apparaître de nouveaux ennemis en vue.
  puts # On ajoute une ligne vide.

  my_game.menu # On affiche le menu des actions disponibles.
  print "> " # On affiche un curseur de saisie.
  user_choice = gets.chomp # On récupère le choix de l'utilisateur.
  my_game.menu_choice(user_choice) # On exécute l'action correspondant au choix de l'utilisateur.

  if my_game.is_still_ongoing? # On vérifie si la partie continue après l'action du joueur.
    puts # On ajoute une ligne vide.
    my_game.enemies_attack # On déclenche la riposte des ennemis visibles.
  end # Fin de la condition de poursuite du jeu.
end # Fin de la boucle principale.

puts # On ajoute une ligne vide.
my_game.end_game # On affiche le message de fin de partie.