 _______________________________________________ 
|                                               |
|  Langstat.sh                                  |
|                                               |
|  Statistique d'utilisation de lettre sur une  |
|  liste de mots.                               |
|                                               |
|  Version 1.0                                  |
|                                               |
|  Auteur: Thomas Mostkowy                      |
|                                               |
|                                               |
|_______________________________________________|

$>./langstat.sh --help
	affiche cette aide

$>./langstat.sh {filename} --letters [LETTER_LIST]
	Donne les statistiques pour le fichier passé en paramètre
	--letters est optionnel et permet de fournir une list de lettre plus restreinte
	LETTER_LIST ne prend en compte que les lettres majuscules
