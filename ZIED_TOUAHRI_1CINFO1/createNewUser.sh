#!/bin/bash

# This script creates an account on the local system.
# You will be prompted for the account name and password.

# Run as root.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.' >&2
   exit 1
fi

# Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user.
# NOTE: You can also use the following command:
#    echo "${USER_NAME}:${PASSWORD}" | chpasswd
# echo ${PASSWORD} | passwd --stdin ${USER_NAME}
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Force password change on first login.
passwd -e ${USER_NAME}
