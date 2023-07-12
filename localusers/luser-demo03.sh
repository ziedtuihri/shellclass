#!/bin/bash

# Display the UID and username of the user executing this script. 
# Display if the user is the vagrant user or not.


# Display the UID
echo "Your UID is ${UID}"

# Only display if the UID does NOT match 1000.
if [[ "${UID}" -ne 1000 ]]
then
	echo "is not 1000 I think you are ROOT "
else
	echo "You are simple user not ROOT"
fi

USER_NAME=$(id -un)

# Display the username
echo "$(id -un)"

# Test if the Command succeeded.
# exit 1 do not this block 0 is Successfully 
if [[ "${?}" -ne 0 ]]
then
	echo "The id command did not execute successfully."
	exit 1
fi

echo "yoiur username is ${USER_NAME}"

# You can use a string test conditional.
# in the if you can use = or != it's like -eq or -ne
USER_NAME_TO_TEST="zied"
if [[ "${USER_NAME}" -eq "${USER_NAME_TO_TEST}" ]]
then
	echo "You are the correct User."
else
	echo "Wrong User sorry !!! "
fi

if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST}" ]]
then
	echo "Wrong User sorry !!!! "
else
	echo "You are the correct User."
fi

exit 0

















