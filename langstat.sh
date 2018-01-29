#!/bin/bash

##############################################################
# langstat.sh                                                #
#                                                            #
# Affiche les statistiques par lettre d'un fichier passé en  #
# paramètre.                                                 #
#                                                            #
# Créé par Thomas Mostkowy <toma.zed@gmail.com>              #
##############################################################



##############################################################
# Default Parameters                                         #
##############################################################

letters=ABCDEFGHIJKLMNOPQRSTUVWXYZ


##############################################################
# Usage                                                      #
##############################################################

usage (){
	echo "Language Statistics V1.0"
	echo ""
	echo "$>$0 --help"
	printf "\taffiche cette aide\r\n"
	echo ""
	echo "$>$0 {filename} --letters [LETTER_LIST]"
	printf "\tDonne les statistiques pour le fichier passé en paramètre\r\n"
	printf "\t--letters est optionnel et permet de fournir une list de lettre plus restreinte\r\n"

}

# Test: Est-ce que l'on a le nom du fichier en paramètre
if [ $# -lt 1 ]; then
	echo "Erreur: Il manque le nom du fichier"
	usage
	exit 1
fi

# Test: Doit on afficher l'aide
if [ "$1" == "--help" ]; then
	usage
	exit 0
fi

# Test: Est-ce que le fichier passé en paramètre existe
if [ -e "$1" ]; then
	filename=$1
else
	echo "Erreur: Le fichier $1 est introuvable"
	usage
	exit 1
fi

# Test: Affichage de l'usage si le nombre de paramètre est incorrect 
if [ "$#" -eq "2" ] || [ "$#" -gt "3" ]; then
	usage
	exit 1
fi

# Test: Est-ce que l'on a un changement de lettres
if [ $# -eq 3 ]; then
       if [ "$2" == "--letters" ]; then
		letters=`echo "$3" | sed 's/[^A-Z]//g'`
	else
		echo "Le parametre $2 est inconnu. Il sera ignoré"
		usage
		exit 1
	fi
fi

# Action: Création d'un fichier temporaire pour stocker les résultats
tmpfile=$(mktemp /tmp/langstat.XXXXXX)

# Action: Itération sur la liste de lettre pour récupérer la statistique de chacune
for (( i=0; i<${#letters}; i++ )); do
	# Action Récupération le la statistique de la lettre et stockage dans le fichier temporaire
	echo `grep ${letters:$i:1} < $filename | wc -l` - ${letters:$i:1} >> $tmpfile
done

# Action: suppression des doublons et tri des résultats
uniq < $tmpfile |sort -n -r

# Action: suppression du fichier temporaire
rm -f $tmpfile
