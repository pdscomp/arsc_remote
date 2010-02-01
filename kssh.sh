#!/usr/bin/env bash
#A quick script to do ARSC logging-in stuff for me.
./chooser.sh
SHELLUSR=`cat ./username`
TEHYUORPC=`cat ./tehyuorpc`
DOMAIN=`cat ./domain`

./krb5/bin/kinit $SHELLUSR@`echo $DOMAIN | tr [:lower:] [:upper:]`
./krb5/bin/klist
./ossh/bin/ssh -XY $SHELLUSR@$TEHYUORPC.arsc.edu
