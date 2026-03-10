require_relative "player" # On charge le fichier player.rb pour pouvoir utiliser Player et HumanPlayer ici.

class Game # On définit la classe Game, qui va gérer toute la logique de la version 3.0.
  attr_accessor :human_player, :players_left, :enemies_in_sight # On crée les accès aux attributs principaux du jeu.

  def initialize(name) # Cette méthode est appelée lorsqu'on crée une nouvelle partie.
    @human_player = HumanPlayer.new(name) # On crée le joueur humain avec le nom saisi par l'utilisateur.
    @players_left = 10 # On indique qu'il reste 10 ennemis à éliminer au total pour gagner.
    @enemies_in_sight = [] # On initialise la liste des ennemis actuellement visibles à un tableau vide.
  end # Fin de la méthode initialize.

  def kill_player(player) # Cette méthode supprime un ennemi mort de la liste des ennemis en vue.
    if @enemies_in_sight.include?(player) # On vérifie d'abord que le joueur fait bien partie des ennemis visibles.
      @enemies_in_sight.delete(player) # On enlève l'ennemi mort du tableau des ennemis en vue.
      @players_left -= 1 # On diminue de 1 le nombre total d'ennemis restant à éliminer.
    end # Fin de la vérification de présence dans la liste.
  end # Fin de la méthode kill_player.

  def is_still_ongoing? # Cette méthode indique si la partie continue ou non.
    return @human_player.life_points > 0 && @players_left > 0 # La partie continue si le joueur humain est vivant et s'il reste des ennemis à éliminer.
  end # Fin de la méthode is_still_ongoing?.

  def show_players # Cette méthode affiche l'état général de la partie.
    puts "Voici ton état :" # On affiche un petit titre avant l'état du joueur humain.
    @human_player.show_state # On affiche l'état détaillé du joueur humain.
    puts "Il reste #{@players_left} ennemi(s) à éliminer." # On affiche le nombre total d'ennemis encore en vie.
    puts "Il y a #{@enemies_in_sight.length} ennemi(s) en vue." # On affiche le nombre d'ennemis actuellement visibles.
  end # Fin de la méthode show_players.

  def menu # Cette méthode affiche le menu des actions possibles pour le joueur.
    puts "Quelle action veux-tu effectuer ?" # On affiche l'intitulé du menu.
    puts "a - chercher une meilleure arme" # On affiche le choix permettant de chercher une arme.
    puts "s - chercher à se soigner" # On affiche le choix permettant de chercher un pack de soin.
    puts # On ajoute une ligne vide pour aérer l'affichage.
    puts "attaquer un joueur en vue :" # On affiche le titre de la partie concernant les attaques.

    if @enemies_in_sight.empty? # On vérifie s'il n'y a actuellement aucun ennemi en vue.
      puts "Aucun ennemi en vue pour le moment." # On informe le joueur qu'il ne peut attaquer personne pour l'instant.
    else # Sinon, on entre dans le cas où il y a au moins un ennemi visible.
      @enemies_in_sight.each_with_index do |enemy, index| # On parcourt tous les ennemis visibles avec leur index.
        print "#{index} - " # On affiche l'index du joueur à taper dans le menu.
        enemy.show_state # On affiche l'état de cet ennemi.
      end # Fin du parcours des ennemis visibles.
    end # Fin de la condition sur la présence d'ennemis en vue.
  end # Fin de la méthode menu.

  def menu_choice(choice) # Cette méthode exécute l'action choisie par l'utilisateur.
    if choice == "a" # On vérifie si le joueur a choisi de chercher une arme.
      @human_player.search_weapon # On lance la recherche d'une meilleure arme.
    elsif choice == "s" # On vérifie si le joueur a choisi de se soigner.
      @human_player.search_health_pack # On lance la recherche d'un pack de soin.
    elsif choice.to_i.to_s == choice && choice.to_i >= 0 && choice.to_i < @enemies_in_sight.length # On vérifie si le choix correspond à un index valide d'ennemi.
      enemy = @enemies_in_sight[choice.to_i] # On récupère l'ennemi ciblé à partir de l'index saisi.
      @human_player.attacks(enemy) # On fait attaquer cet ennemi par le joueur humain.

      if enemy.life_points <= 0 # On vérifie si l'ennemi est mort après l'attaque.
        kill_player(enemy) # On enlève cet ennemi du jeu visible et du nombre total restant.
      end # Fin de la vérification de mort de l'ennemi.
    else # Sinon, on entre dans le cas où le choix de l'utilisateur n'est pas valide.
      puts "Choix invalide, tu perds ton tour." # On informe l'utilisateur que son action n'est pas reconnue.
    end # Fin de la gestion des différents choix possibles.
  end # Fin de la méthode menu_choice.

  def enemies_attack # Cette méthode permet à tous les ennemis visibles de riposter.
    puts "Les autres joueurs t'attaquent !" # On annonce la phase d'attaque des ennemis.

    @enemies_in_sight.each do |enemy| # On parcourt tous les ennemis actuellement en vue.
      if enemy.life_points > 0 && @human_player.life_points > 0 # On vérifie que l'ennemi est vivant et que le joueur humain l'est aussi.
        enemy.attacks(@human_player) # On fait attaquer le joueur humain par cet ennemi.
      end # Fin de la condition permettant l'attaque.
    end # Fin du parcours de tous les ennemis visibles.
  end # Fin de la méthode enemies_attack.

  def new_players_in_sight # Cette méthode gère l'arrivée de nouveaux ennemis dans le champ de vision.
    if @enemies_in_sight.length == @players_left # On vérifie si tous les ennemis restants sont déjà visibles.
      puts "Tous les joueurs sont déjà en vue." # On informe l'utilisateur qu'aucun nouvel ennemi ne peut apparaître.
      return # On quitte immédiatement la méthode.
    end # Fin de la condition de sortie anticipée.

    dice = rand(1..6) # On lance un dé pour savoir combien de nouveaux ennemis arrivent.

    if dice == 1 # On vérifie si le résultat du dé vaut 1.
      puts "Aucun nouvel ennemi n'arrive en vue." # On annonce qu'aucun ennemi n'arrive ce tour-ci.
    elsif dice >= 2 && dice <= 4 # On vérifie si le résultat est compris entre 2 et 4.
      add_one_enemy # On ajoute un seul nouvel ennemi en vue.
    else # Sinon, cela signifie que le résultat vaut 5 ou 6.
      enemies_to_add = [2, @players_left - @enemies_in_sight.length].min # On calcule combien d'ennemis on peut ajouter sans dépasser le total restant.
      enemies_to_add.times do # On répète l'ajout autant de fois que nécessaire.
        add_one_enemy # On ajoute un nouvel ennemi en vue à chaque itération.
      end # Fin de la boucle de création des ennemis.
    end # Fin de la gestion du résultat du dé.
  end # Fin de la méthode new_players_in_sight.

  def end_game # Cette méthode affiche le message de fin de partie.
    puts "La partie est finie" # On annonce que la partie est terminée.

    if @human_player.life_points > 0 # On vérifie si le joueur humain est encore vivant.
      puts "BRAVO ! TU AS GAGNÉ !" # On affiche le message de victoire.
    else # Sinon, cela signifie que le joueur humain est mort.
      puts "Loser ! Tu as perdu !" # On affiche le message de défaite.
    end # Fin de la condition de fin de partie.
  end # Fin de la méthode end_game.

  private # On indique que les méthodes ci-dessous sont privées à la classe Game.

  def add_one_enemy # Cette méthode privée crée un nouvel ennemi et l'ajoute à la liste des ennemis visibles.
    enemy = Player.new("joueur_#{rand(1000..9999)}") # On crée un nouvel ennemi avec un nom aléatoire.
    @enemies_in_sight << enemy # On ajoute cet ennemi au tableau des ennemis visibles.
    puts "#{enemy.name} arrive en vue !" # On annonce l'arrivée du nouvel ennemi.
  end # Fin de la méthode add_one_enemy.
end # Fin de la classe Game.