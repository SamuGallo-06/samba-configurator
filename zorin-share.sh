#!/bin/bash

# Change to the application directory
cd /usr/share/zorin-share || exit 1

if [ "$EUID" -ne 0 ]; then
  pkexec /usr/bin/python3 /usr/share/zorin-share/main.py "$@"
else
  /usr/bin/python3 /usr/share/zorin-share/main.py "$@"
fi