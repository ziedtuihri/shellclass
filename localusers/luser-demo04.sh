#!/bin/bash

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for:' COMMENT

# Ask for the password.
read -p 'Enter the Password to use for the account: ' PASSWORD

# Create the user.
useradd -c "${COMMENT}" -m ${USERNAME}

# Set the Password for the user.
# NOTE: You can also use the following command:
# echo "${USER_NAME}:${PASSWORD}" | chpasswd
# echo ${PASSWORD} | passwd --stdin ${USER_NAME}
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Force password change on first login.
passwd -e ${USER_NAME}





















