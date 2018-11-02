#! /bin/sh
# Test zombie process before you shut down your server
if [ -z "$( ps -o state | grep Z )" ]; then
  echo "[0;32mGood Job![m"
else
  echo "[0;31mYou left zombie processes in the system![m"
fi
