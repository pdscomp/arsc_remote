#!/usr/bin/env bash

#A quick script to do ARSC logging-in stuff for me.
SHELLUSR='holbrook'
DOMAIN='arsc.edu'
TEHYUORPC='hookbill'

kinit $SHELLUSR@`echo $DOMAIN | tr [:lower:] [:upper:]`
klist
ssh -XY $SHELLUSR@$TEHYUORPC.arsc.edu
