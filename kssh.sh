#!/usr/bin/env bash
#A quick script to do ARSC logging-in stuff for me.
#kssh SHELLUSR TEHYUORPC

SHELLUSR=$1
TEHYUORPC=$2
DOMAIN='arsc.edu'

kinit $SHELLUSR@`echo $DOMAIN | tr [:lower:] [:upper:]`
klist
ssh -XY $SHELLUSR@$TEHYUORPC.arsc.edu
