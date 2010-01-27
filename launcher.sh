#!/usr/bin/env bash
#This serves as a "launcher" for kssh.sh, which
#needs to run inside kshell to work properly.

gnome-terminal -e 'kshell -c "./kssh.sh"' &
