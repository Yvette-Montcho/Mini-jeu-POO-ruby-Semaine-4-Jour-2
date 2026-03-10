class Player # On définit la classe Player, qui représente un joueur classique du jeu.
  attr_accessor :name, :life_points # On crée les getters et setters pour le nom et les points de vie.

  def initialize(name) # Cette méthode est appelée automatiquement quand on crée un nouveau joueur.
    @name = name # On stocke le nom reçu en paramètre dans la variable d'instance @name.
    @life_points = 10 # On donne 10 points de vie par défaut à chaque joueur classique.
  end # Fin de la méthode initialize.

  def show_state # Cette méthode sert à afficher l'état actuel du joueur.
    puts "#{@name} a #{@life_points} points de vie" # On affiche le nom du joueur et ses points de vie.
  end # Fin de la méthode show_state.

  def gets_damage(damage) # Cette méthode permet au joueur de subir des dégâts.
    @life_points -= damage # On retire les dégâts reçus au nombre de points de vie du joueur.
    @life_points = 0 if @life_points < 0 # On évite que les points de vie descendent en dessous de zéro.

    if @life_points <= 0 # On vérifie si le joueur n'a plus de points de vie.
      puts "le joueur #{@name} a été tué !" # On affiche un message pour annoncer que le joueur est mort.
    end # Fin de la condition de mort.
  end # Fin de la méthode gets_damage.

  def attacks(other_player) # Cette méthode permet à un joueur d'attaquer un autre joueur.
    puts "#{@name} attaque #{other_player.name}" # On annonce quel joueur attaque quel autre joueur.
    damage = compute_damage # On calcule aléatoirement le nombre de dégâts infligés.
    puts "il lui inflige #{damage} points de dommages" # On affiche le nombre de dégâts infligés.
    other_player.gets_damage(damage) # On applique ces dégâts au joueur attaqué.
  end # Fin de la méthode attacks.

  def compute_damage # Cette méthode calcule les dégâts infligés par un joueur classique.
    return rand(1..6) # On retourne un nombre aléatoire entre 1 et 6 comme un lancer de dé.
  end # Fin de la méthode compute_damage.
end # Fin de la classe Player.

class HumanPlayer < Player # On définit la classe HumanPlayer, qui hérite de la classe Player.
  attr_accessor :weapon_level # On crée les getters et setters pour le niveau d'arme.

  def initialize(name) # Cette méthode est appelée lorsqu'on crée un joueur humain.
    super(name) # On appelle le initialize de la classe mère Player pour récupérer le nom.
    @life_points = 100 # On donne 100 points de vie au joueur humain au lieu de 10.
    @weapon_level = 1 # On initialise son arme au niveau 1.
  end # Fin de la méthode initialize.

  def show_state # Cette méthode affiche l'état du joueur humain.
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}" # On affiche la vie et le niveau d'arme.
  end # Fin de la méthode show_state.

  def compute_damage # Cette méthode redéfinit les dégâts pour le joueur humain.
    return rand(1..6) * @weapon_level # On multiplie les dégâts par le niveau de l'arme.
  end # Fin de la méthode compute_damage.

  def search_weapon # Cette méthode permet au joueur humain de chercher une nouvelle arme.
    new_weapon_level = rand(1..6) # On génère aléatoirement le niveau de la nouvelle arme trouvée.
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}" # On annonce le niveau de l'arme trouvée.

    if new_weapon_level > @weapon_level # On vérifie si la nouvelle arme est meilleure que l'ancienne.
      @weapon_level = new_weapon_level # Si elle est meilleure, on remplace l'ancienne arme.
      puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends." # On annonce que le joueur prend la nouvelle arme.
    else # Sinon, on entre dans le cas où l'arme n'est pas meilleure.
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..." # On annonce que le joueur garde son arme actuelle.
    end # Fin de la condition sur le niveau de l'arme.
  end # Fin de la méthode search_weapon.

  def search_health_pack # Cette méthode permet au joueur humain de chercher un pack de soin.
    dice = rand(1..6) # On lance un dé pour déterminer ce que le joueur trouve.

    if dice == 1 # On vérifie si le résultat du dé vaut 1.
      message = "Tu n'as rien trouvé..." # On prépare le message correspondant à l'absence de soin.
    elsif dice >= 2 && dice <= 5 # On vérifie si le résultat est compris entre 2 et 5.
      @life_points += 50 # On ajoute 50 points de vie au joueur.
      @life_points = 100 if @life_points > 100 # On limite les points de vie à 100 maximum.
      message = "Bravo, tu as trouvé un pack de +50 points de vie !" # On prépare le message de succès.
    else # Sinon, cela signifie que le résultat du dé vaut 6.
      @life_points += 80 # On ajoute 80 points de vie au joueur.
      @life_points = 100 if @life_points > 100 # On limite les points de vie à 100 maximum.
      message = "Waow, tu as trouvé un pack de +80 points de vie !" # On prépare le message correspondant.
    end # Fin de la condition sur le résultat du dé.

    puts message # On affiche le message final au joueur.
    return message # On retourne aussi le message pour rester proche de la consigne.
  end # Fin de la méthode search_health_pack.
end # Fin de la classe HumanPlayer.