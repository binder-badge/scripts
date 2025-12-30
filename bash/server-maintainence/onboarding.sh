#! /bin/bash
# A script I developed to automate the process of adding new users to the SSE's server\
# script takes in 3 args in this order: "username" "full name" "path/to/pubkey.pub"
USERNAME=$1
FULL_NAME=$2
PASSWORD=$(echo $RANDOM | md5sum | head -c 12)
PUBKEY_FILE=$3
PUBKEY=$(cat "$PUBKEY_FILE")

ADMIN_USER="admin"
ADMIN_PASS=$(cat ./admin_pass) # at least make it so that I dont need to manually get rid of my admin password
SERVER="server.domain.com"

ssh $ADMIN_USER@$SERVER "echo $ADMIN_PASS | sudo -S useradd -m -c '$FULL_NAME' $USERNAME"
ssh $ADMIN_USER@$SERVER "echo -e '$ADMIN_PASS\n$PASSWORD\n$PASSWORD' | sudo -S passwd $USERNAME"

printf "Added and configured $USERNAME\n$USERNAME's password is $PASSWORD\n"

ssh $ADMIN_USER@$SERVER "echo $ADMIN_PASS | sudo -S usermod -aG docker $USERNAME"
echo "Added $USERNAME to Docker group"

ssh $ADMIN_USER@$SERVER "echo $PUBKEY > ./temp_authorized_keys"
ssh $ADMIN_USER@$SERVER "echo $ADMIN_PASS | sudo -S mkdir ~$USERNAME/.ssh"
ssh $ADMIN_USER@$SERVER "echo $ADMIN_PASS | sudo -S touch ~$USERNAME/.ssh/authorized_keys"
ssh $ADMIN_USER@$SERVER "echo $ADMIN_PASS | sudo -S cp ./temp_authorized_keys ~$USERNAME/.ssh/authorized_keys"
ssh $ADMIN_USER@$SERVER "rm ./temp_authorized_keys"
echo "Added $PUBKEY_FILE to $USERNAME"

