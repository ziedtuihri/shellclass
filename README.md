# shellclass

how to use the project 

to create users for test
sudo ./createNewUser.sh

for managements users
sudo ./gestion_user.sh [-h|--help] [-g] [-v] [-m]


<br>
On peut verrouiller un compte utilisateur de plusieurs manières.
<br>
En préfixant le mot de passe dans /etc/passwd par un “!”. Si vous utilisez les mots de passe masqués shadow, remplacez x par un *.
<br>
C’est ce que font les commandes suivantes :
<br>
pour verrouiller passwd -l ou usermod -L<br>
pour déverrouiller passwd -u ou usermod -U<br>

test if user is locked or no <br>
sudo grep ziedth3 /etc/shadow<br>

example of the result <br>
ziedth3:!$y$j9T$aaRRyCXDKlGSgQdOg0Ygy1$on67ikXvfqfxsY9ks.22SCG0CIwkule8oIRdokJJde8:0:0:99999:7:::
<br>
user ziedth3 but after the first : there is an ! because is locked <br>

if you don't have ! after the first : is unlocked :) ^_^<br>


<br>
Il suffit de modifier, grâce à n'importe quel éditeur de texte, le fichier /etc/passwd, qui<br> contient une ligne par utilisateur & plusieurs champs par ligne, séparés par ':'. <br>
Un des champs contient le répertoire par défaut.
<br>

pour tester tapé <br>
sudo grep ziedth3 /etc/passwd
































