require_relative "lib/game" # On charge le fichier game.rb.
require_relative "lib/player" # On charge le fichier player.rb.

player1 = Player.new("Josiane") # On crée le premier joueur qui s'appelle Josiane.
player2 = Player.new("José") # On crée le deuxième joueur qui s'appelle José.

while player1.life_points > 0 && player2.life_points > 0 # On lance une boucle qui continue tant que les deux joueurs sont vivants.
  puts "Voici l'état de nos joueurs :" # On affiche un titre pour présenter l'état des deux joueurs.
  player1.show_state # On affiche l'état actuel de Josiane.
  player2.show_state # On affiche l'état actuel de José.
  puts # On ajoute une ligne vide pour rendre l'affichage plus lisible.

  puts "Passons à la phase d'attaque :" # On annonce le début de la phase d'attaque.
  player1.attacks(player2) # On fait attaquer José par Josiane.

  break if player2.life_points <= 0 # On arrête immédiatement la boucle si José est mort après cette attaque.

  player2.attacks(player1) # Sinon, on fait riposter José contre Josiane.
  puts # On ajoute une ligne vide pour aérer l'affichage.
  puts "-----------------------------------------" # On affiche une ligne de séparation entre deux tours.
  puts # On ajoute encore une ligne vide pour la lisibilité.
end # Fin de la boucle de combat.

puts "Le combat est terminé !" # On annonce que le combat est fini.

if player1.life_points > 0 # On vérifie si Josiane est encore en vie.
  puts "#{player1.name} a gagné !" # On affiche que Josiane a gagné.
else # Sinon, cela veut dire que José est le vainqueur.
  puts "#{player2.name} a gagné !" # On affiche que José a gagné.
end # Fin de la condition sur le vainqueur.