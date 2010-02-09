#!/usr/bin/env bash

#Some handy variables
SHELLUSR=`cat ./config/username`
#TEHYUORPC=`cat ./config/tehyuorpc`
DOMAIN='arsc.edu'
CONFIGFILE='./config/ssh_config'
export SHELLUSR
#export TEHYUORPC
export DOMAIN
export CONFIGFILE

#adds special krb5 and ossh paths
PATH=./scripts:$PATH
export PATH

kshell
