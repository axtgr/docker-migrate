#!/bin/sh

if [ -n "$HOST" ]; then
  echo "STARTING MIGRATE CLIENT"
  rsync --info=progress2,stats3 -razhe "sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -l root" $HOST:/volumes/ /volumes "$@"
else
  echo "STARTING MIGRATE SERVER"
  echo "root:$PASSWORD" | chpasswd
  /usr/sbin/sshd -De
fi
