#!/bin/sh

if [ -n "$HOST" ]; then
  echo "STARTING MIGRATE CLIENT"
  PORT=${PORT:-8722}
  rsync --info=progress2,stats3 -razhe "sshpass -p $PASSWORD ssh -o StrictHostKeyChecking=no -l root -p $PORT" $HOST:/volumes/ /volumes "$@"
else
  echo "STARTING MIGRATE SERVER"
  echo "root:$PASSWORD" | chpasswd
  /usr/sbin/sshd -De
fi
