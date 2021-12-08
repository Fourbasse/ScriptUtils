#!/bin/bash

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'

path="/cygdrive/c/Users/jbenslim/script/django/"
server_launch="manage.py runserver"
migrate_launch="manage.py migrate"
makemigrations_launch="manage.py makemigrations"

liste_projet=$(ls -l $path | awk '{print $10}' | tr '\n' ' / ')
liste_action="start/ migrate/ makemigrations"
echo -e "${BLUE}############ Django action ############${NOCOLOR}"

# echo $liste_projet

read -p "Veuillez selectionnez un projet django ($liste_projet) :" projet

#verification renseignement de l'argument projet
test=$(echo $liste_projet | grep -wc "$projet")

if [ $test -eq 0 ]
then
	echo -e "[${RED}Error${NOCOLOR}] Projet non existant\n[${BLUE}Info${NOCOLOR}] Sortie du script"
	exit 1
else
	read -p "Que souhaitez vous faire ($liste_action) ? " action
	#verification si l'action est valide
	test=$(echo $liste_action | grep -c "$action")
	if [ $test -eq 0 ]
	then
		echo -e "[${RED}Error${NOCOLOR}] Action non existante\n[${BLUE}Info${NOCOLOR}] Sortie du script"
		exit 1
	else
		echo -e "[${BLUE}Info${NOCOLOR}] $action du projet : ${PURPLE}$projet${NOCOLOR}"
		case $action in
			"start") cd ${path}${projet} ; ./${server_launch};;
			"migrate") cd ${path}${projet} ; ./${migrate_launch};
				if [ $? -eq 0 ]
				then
					echo -e "[${GREEN}Success${NOCOLOR}] Le migrate s'est bien derouler"
				else
					echo -e "[${RED}Failed${NOCOLOR}] Probleme rencontre lors du migrate"
				fi;;
			"makemigrations") cd ${path}${projet}; ./${makemigrations_launch};
				if [ $? -eq 0 ]
				then
					echo -e "[${GREEN}Success${NOCOLOR}] Le makemigrations s'est bien derouler"
				else
					echo -e "[${RED}Failed${NOCOLOR}] Probleme rencontre lors du makemigrations"
				fi;;
		esac
	fi
fi
		
