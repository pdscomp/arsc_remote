##ABOUT:##

arsc_remote is meant to be a set of tools that makes using the hpcmp krb and 
ssh less of a pain to use.  Unfortunately, they're such a kludge that trying
to make it less of a pain is, well, a pain. At the very least, my goal is to
describe how to get everything rolling with the least amount of heartache.

##TODO:##

1. Make gkshell open up a kshell'd gnome-terminal.
2. kssh script that opens kshell, kinit and /then/ ssh ?
3. kscp script that does same ?
4. Find some way to automate the krb5/ssh downloads.

##DIRECTIONS:##

1. Download the krb5 and ssh bundles from 
<https://www.hpcmo.hpc.mil/security/kerberos/>. This requires a 
javascript-enabled browser---that is, wget doesn't work, even with https action
enabled.

2. 
    a. In order to use the krb5 files, add the /bin to your path and point the
    KRB5_CONFIG variable to krb5.conf.  

    b. The easiest way to get the ossh bundle working is to run install.user as
    yourself. Then, if it's not already there, you should add ~/bin to your 
    PATH. Moreover, ~/bin should be placed early in your path, so that you 
    don't end up trying to run /bin/ssh when you mean to run ~/bin/ssh.
    In fact, the ~/.ssh/ssh.config that comes with hpcmp's ssh has options that 
    *break* regular ssh. If you get configuration errors, try **which ssh** to
    check for that issue.

    c. To implement all this, I just added the following to my .bash_profile:

    PATH=$HOME/bin/krb5/bin:$HOME/bin:$PATH; export PATH
    KRB5_CONFIG=$HOME/bin/krb5/krb5.conf; export KRB5_CONFIG

3. To actually use this stuff:

    a. Run kshell. It's some kinda security sandbox thing that they require you
    to run everything in.

    b. Typetty-type:
        kinit user@DOMAIN.TLD

    Enter in your password, use the SecurID, etc. This gives you a krb5 
    ticket with the ARSC system for Xty minutes.

    c. You're almost there!
        ssh user@pc.domain.tld

    d. *(optional)* If you're ever wondering about your ticket status, use 
    **klist**. I didn't actually find it that useful, though.
