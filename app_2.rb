require_relative "lib/game" # On charge le fichier game.rb.
require_relative "lib/player" # On charge le fichier player.rb.

puts "-------------------------------------------------" # On affiche la première ligne du message d'accueil.
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |" # On affiche le titre du jeu.
puts "|Le but du jeu est d'être le dernier survivant !|" # On affiche l'objectif du jeu.
puts "-------------------------------------------------" # On affiche la dernière ligne du message d'accueil.
puts # On ajoute une ligne vide pour la lisibilité.

print "Quel est ton prénom ? " # On demande à l'utilisateur de saisir son prénom.
user_name = gets.chomp # On récupère au clavier le prénom de l'utilisateur.

user = HumanPlayer.new(user_name) # On crée le joueur humain avec le prénom choisi.
player1 = Player.new("Josiane") # On crée un ennemi nommé Josiane.
player2 = Player.new("José") # On crée un ennemi nommé José.
enemies = [player1, player2] # On stocke les deux ennemis dans un tableau pour pouvoir les parcourir facilement.

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0) # On continue la partie tant que le joueur humain est vivant et qu'au moins un ennemi est vivant.
  puts # On ajoute une ligne vide.
  puts "-----------------------------------------" # On affiche une ligne de séparation entre les tours.
  puts # On ajoute une autre ligne vide.

  user.show_state # On affiche l'état actuel du joueur humain.
  puts # On ajoute une ligne vide.

  puts "Quelle action veux-tu effectuer ?" # On affiche le titre du menu des actions.
  puts "a - chercher une meilleure arme" # On affiche l'option de recherche d'arme.
  puts "s - chercher à se soigner" # On affiche l'option de recherche de soin.
  puts # On ajoute une ligne vide.
  puts "attaquer un joueur en vue :" # On affiche la partie du menu consacrée aux attaques.

  if player1.life_points > 0 # On vérifie si Josiane est encore en vie.
    print "0 - " # On affiche l'index 0 dans le menu.
    player1.show_state # On affiche l'état de Josiane.
  else # Sinon, cela signifie que Josiane est morte.
    puts "0 - Josiane est déjà morte" # On l'indique dans le menu.
  end # Fin de la condition liée à Josiane.

  if player2.life_points > 0 # On vérifie si José est encore en vie.
    print "1 - " # On affiche l'index 1 dans le menu.
    player2.show_state # On affiche l'état de José.
  else # Sinon, cela signifie que José est mort.
    puts "1 - José est déjà mort" # On l'indique dans le menu.
  end # Fin de la condition liée à José.

  print "> " # On affiche un petit curseur pour la saisie utilisateur.
  choice = gets.chomp # On récupère le choix saisi par l'utilisateur.

  if choice == "a" # On vérifie si l'utilisateur veut chercher une arme.
    user.search_weapon # On lance la recherche d'une meilleure arme.
  elsif choice == "s" # On vérifie si l'utilisateur veut chercher un pack de soin.
    user.search_health_pack # On lance la recherche d'un pack de soin.
  elsif choice == "0" # On vérifie si l'utilisateur veut attaquer Josiane.
    if player1.life_points > 0 # On vérifie que Josiane est bien encore vivante.
      user.attacks(player1) # On fait attaquer Josiane par le joueur humain.
    else # Sinon, cela veut dire qu'elle est déjà morte.
      puts "Tu ne peux pas attaquer un joueur déjà mort." # On informe l'utilisateur que l'action est impossible.
    end # Fin de la vérification sur Josiane.
  elsif choice == "1" # On vérifie si l'utilisateur veut attaquer José.
    if player2.life_points > 0 # On vérifie que José est bien encore vivant.
      user.attacks(player2) # On fait attaquer José par le joueur humain.
    else # Sinon, cela veut dire qu'il est déjà mort.
      puts "Tu ne peux pas attaquer un joueur déjà mort." # On informe l'utilisateur que l'action est impossible.
    end # Fin de la vérification sur José.
  else # Sinon, cela signifie que le choix saisi n'est pas reconnu.
    puts "Choix invalide, tu perds ton tour." # On informe l'utilisateur que son tour est perdu.
  end # Fin de la gestion du choix utilisateur.

  break if player1.life_points <= 0 && player2.life_points <= 0 # On arrête la boucle si les deux ennemis sont morts.

  puts # On ajoute une ligne vide.
  puts "Les autres joueurs t'attaquent !" # On annonce la phase de riposte des ennemis.

  enemies.each do |enemy| # On parcourt chaque ennemi du tableau enemies.
    if enemy.life_points > 0 && user.life_points > 0 # On vérifie que l'ennemi est vivant et que le joueur humain l'est aussi.
      enemy.attacks(user) # On fait attaquer le joueur humain par cet ennemi.
    end # Fin de la condition autorisant l'attaque.
  end # Fin du parcours des ennemis.
end # Fin de la boucle principale du jeu.

puts # On ajoute une ligne vide.
puts "La partie est finie" # On annonce que la partie est terminée.

if user.life_points > 0 # On vérifie si le joueur humain a survécu.
  puts "BRAVO ! TU AS GAGNÉ !" # On affiche le message de victoire.
else # Sinon, cela signifie que le joueur humain est mort.
  puts "Loser ! Tu as perdu !" # On affiche le message de défaite.
end # Fin de la condition de fin de partie.