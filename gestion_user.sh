#!/bin/bash

# Show how to use
function show_usage(){
  echo "gestion_user.sh: [-h|--help] [-g] [-v] [-m]"
  exit 1
}

# Test for arguments
if [ $# -eq 0 ]; then
  echo "Add an argument please!"
  show_usage
  exit 1
fi

# Help to use the script.
function HELP(){
  cat ./help.txt
}

# Function for dernier_cnx
function lock(){
echo "lock"
}

# Function for journal
function unlock(){
echo "unlock"
}

# Function for supp_entry
function modify_directory(){
echo "modify_directory"
}

# Function for nom_v
function nom_v(){
  echo "ZIED TOUAHRI 1CINFO1 @version 1.00 Gestion des utilisateurs"
}

# Afficher le menu à choix multiple Yad
function affichage(){
  champ=$(yad --title="Window Management users ZIED TOUAHRI 1CINFO1" --form --button="help":1 --button="Lock the account":2 --button="Unlock the account":3 --button="Modify directory":4)
  fon=$?
  if [[ $fon -eq 1 ]]; then
    HELP
  elif [[ $fon -eq 2 ]]; then
    read -p "Entrez les noms d'utilisateur : " users
    lock $users
  elif [[ $fon -eq 3 ]]; then
    read -p "Entrez les noms d'utilisateur : " users
    unlock $users
  elif [[ $fon -eq 4 ]]; then
    read -p "Entrez les noms d'utilisateur : " users
    modify_directory $users
  fi
}

while getopts "hgvm" opt; do
  case $opt in
    h)
      HELP
      exit 0
      ;;
    m)
      cat ./img.txt
      echo ""
      echo "1. verouiller le compte d’un utilisateur et l’ajouter un fichier liste_user_v"
      echo "2. déverouiller le compte d’un utilisateur et le supprimer du fichier liste_user_v"
      echo "3. Les noms et la version du script"
      echo "4. modifier le repertoire personnel de l’utilisateur et copier le contenu de son ancien répertoire vers le nouveau"
      read -p "Choisissez une option: " option
      case $option in
        1)
          read -p "Entrez les noms d'utilisateur : " users
          lock $users
          ;;
        2)
          read -p "Entrez les noms d'utilisateur : " users
          unlock $users
          ;;
        3)
          nom_v
          ;;
        4)
          modify_directory
          ;;
        *)
          echo "Option not valide !!!!!"
          show_usage
          exit 1
          ;;
      esac
      exit 0
      ;;
    g)
      affichage
      exit
      ;;
    v)
      nom_v
      exit
      ;;
    *)
      echo "Option non valide"
      show_usage
      exit 1
      ;;
  esac
done
