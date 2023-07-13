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

# Function for locking the account
function lock(){
  local user=$1
  passwd -l $user
  echo $user >> liste_user_v
  echo "Account locked for user: $user"
}

# Function for unlocking the account
function unlock(){
  local user=$1
  passwd -u $user
  sed -i "/^$user$/d" liste_user_v
  echo "Account unlocked for user: $user"
}

# Function for modifying the user's home directory
function modify_directory(){
  local user=$1

  read -p "Entrez le nouveau chemin de répertoire (ex. /home/nomRep): " new_directory
  
# Run the command and extract the home directory field
  old_directory=$(sudo grep "$user" /etc/passwd | awk -F: '{print $6}')

# Print the extracted directory name
  echo "************ $old_directory"

# Create the new directory if it doesn't exist
  if [ ! -d "$new_directory" ]; then
    mkdir -p "$new_directory"
    if [ $? -eq 0 ]; then
      echo "Nouveau répertoire '$new_directory' créé."
    else
      echo "Erreur : Échec de la création du nouveau répertoire '$new_directory'."
      return
    fi
  fi
    
  # Check if the user's home directory exists
  if [ ! -d "$old_directory" ]; then
    echo "Erreur : Le répertoire personnel de l'utilisateur '$old_directory' n'existe pas."
    return
  fi
  
  # Check if the user's home directory is empty
  if [ -z "$(ls -A "$old_directory")" ]; then
    echo "Le répertoire personnel de l'utilisateur '$old_directory' est vide."
  else
    # Copy the files to the new directory
    cp -r "$old_directory"/* "$new_directory/"
    
    # Check if the copy operation was successful
    if [ $? -eq 0 ]; then
      echo "Les fichiers ont été copiés avec succès de '$old_directory' vers '$new_directory'."
    else
      echo "Erreur : Échec de la copie des fichiers de '$old_directory' vers '$new_directory'."
    fi
  fi



  # Change the ownership of the new directory
  chown "$user:$user" "$new_directory"
  echo "Changement du propriétaire du nouveau répertoire de home :"
  echo "root@home:~$ chown $user:$user $new_directory"

  # Modify the user's home directory
  usermod -d "$new_directory" "$user"
  echo "Répertoire modifié pour l'utilisateur : $user"
}


# Function for displaying the script version and author information
function nom_v(){
  echo "ZIED TOUAHRI 1CINFO1 @version 1.00 Gestion des utilisateurs"
}

# Afficher le menu à choix multiple Yad
function affichage(){
  champ=$(yad --title="Window Management users ZIED TOUAHRI 1CINFO1" --form --button="help":1 --button="Lock the account":2 --button="Unlock the account":3 --button="Modify Home directory":4)
  fon=$?
  if [[ $fon -eq 1 ]]; then
    HELP
  elif [[ $fon -eq 2 ]]; then
    read -p "Entrez les noms d'utilisateur : " user
    lock $user
  elif [[ $fon -eq 3 ]]; then
    read -p "Entrez les noms d'utilisateur : " user
    unlock $user
  elif [[ $fon -eq 4 ]]; then
    read -p "Entrez les noms d'utilisateur : " user
    modify_directory $user
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
      echo "1. Verrouiller le compte d'un utilisateur et l'ajouter à un fichier liste_user_v"
      echo "2. Déverrouiller le compte d'un utilisateur et le supprimer du fichier liste_user_v"
      echo "3. Les noms et la version du script"
      echo "4. Modifier le répertoire personnel de l'utilisateur et copier le contenu de son ancien répertoire vers le nouveau"
      read -p "Choisissez une option: " option
      case $option in
        1)
          read -p "Entrez le nom de l'utilisateur : " user
          lock $user
          ;;
        2)
          read -p "Entrez le nom de l'utilisateur : " user
          unlock $user
          ;;
        3)
          nom_v
          ;;
        4)
          read -p "Entrez le nom de l'utilisateur : " user
          modify_directory $user
          ;;
        *)
          echo "Option invalide !!!!!"
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
      echo "Option invalide"
      show_usage
      exit 1
      ;;
  esac
done
