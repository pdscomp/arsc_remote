#!/usr/bin/env python

#Put your 'puter names here!
hosts=['hookbill',
       'magpie',
       'mallard',
       'puffin',
       'ruddy',
       'wood']

domain='arsc.edu'
user='holbrook'

for host in hosts:
    print 'Host '+host
    print 'User '+user
    print 'Hostname '+host+'.'+domain+'\n'
 
