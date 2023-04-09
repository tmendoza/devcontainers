#!/bin/bash

ENVNAME=$1

if [[ $# -lt 1 ]]
then
    echo "usage: simple-backup.sh <LXC container name>"
    echo 
    echo "example:"
    echo "    simple-backup.sh ubuntu-22-04-python3-11"
    echo 
    exit 111
fi

lxc list | grep "$ENVNAME" >> /dev/null 2>&1

if [[ $? -ne 0 ]]
then
    echo "$ENVNAME is not a valid LXC container name." 
    exit 111
fi

if [ -d $HOME/backups/containers/$ENVNAME ]
then
    mkdir -p $HOME/backups/containers/$ENVNAME
fi

if [ ! -d /tmp/backup/$ENVNAME ]
then
    mkdir -p /tmp/backup/$ENVNAME 
fi

## Copy the files from the LXC instance
lxc file pull $ENVNAME/home/ubuntu /tmp/backup/$ENVNAME/ -r

# Check for any errors
if [[ $? -ne 0 ]]
then
    echo "There was an error running the 'lxc file pull' command."
    exit 111
fi

cd /tmp/backup/$ENVNAME

# Create the archived/compressed backup
tar -zcvf $HOME/backups/containers/$ENVNAME/ubuntu-`date '+%y-%m-%d-%s'`.tar.gz ./ubuntu

# 'cd' over to the archive directory
cd $HOME/backups/containers/$ENVNAME/

# Show what is there
ls -ltr

## Cleanup the old /tmp directories
rm -R -f /tmp/backup
