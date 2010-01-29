#!/usr/bin/env bash
#A quick script to do ARSC logging-in stuff for me.
./chooser.sh
SHELLUSR=`cat ./username`
TEHYUORPC=`cat ./tehyuorpc`
DOMAIN=`cat ./domain`

kinit $SHELLUSR@`echo $DOMAIN | tr [:lower:] [:upper:]`
klist
ssh -XY $SHELLUSR@$TEHYUORPC.arsc.edu
