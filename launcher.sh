#!/usr/bin/env bash
#This serves as a "launcher" for kssh.sh, which
#needs to run inside kshell to work properly.
#substitute in whatever terminal you like.

gnome-terminal -e "kshell -c './kssh.sh'" &

