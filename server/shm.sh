#! /bin/sh
# Test shared memory after you shut down your server
if [ -z "$( ipcs -m | grep $( whoami ) )" ]; then
  echo "[0;32mGood Job![m"
else
  echo "[0;31mYou left shared memory processes in the system![m"
fi
