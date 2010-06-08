TODO:

1) install.user, make sure everything assumes this
2) kssh script that opens kshell, kinit and /then/ ssh
3) kscp script that does same

DIRECTIONS:

1) Download the krb5 and ssh bundles from 
https://www.hpcmo.hpc.mil/security/kerberos/. Requires a javascript-enabled 
browser. :(

2) In order to use the krb5 files, add the /bin to your path and point the
KRB5_CONFIG variable to krb5.conf .  The easiest way to get the ossh bundle
working is to run install.user as yourself. Then, if it's not already there,
you should add ~/bin to your PATH.

To implement all this, I just added the following to my .bash_profile:

> PATH=$HOME/bin/krb5/bin:$PATH:$HOME/bin; export PATH
> KRB5_CONFIG=$HOME/bin/krb5/krb5.conf; export KRB5_CONFIG

3) To actually use this stuff:
    a) Run kshell. It's some kinda security sandbox thing that they require you
       to run everything in.
    b) > kinit user@DOMAIN.TLD
       Enter in your password, use the SecurID, etc. This gives you a krb5 
       ticket with the ARSC system for xty minutes.
    c) > ssh user@pc.domain.tld
       (MAGIC!)
    d) (optional) If you're ever wondering about your ticket status, use klist.
