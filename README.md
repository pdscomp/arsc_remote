##ABOUT:##

arsc_remote was meant to be a set of tools that makes using the hpcmp krb and 
ssh bundles for *nix (Windows is pretty easy as-is if you don't want X-
tunneling) less of a pain to use.  Ironically, it instead turned out to be 
a small handfull of tools combined with a README that describes how I set
everything up for myself. My goal is to describe how to get everything rolling
with the least amount of heartache.

##TODO:##

* Find some way to automate the krb5/ssh downloads.
* Test out scp, etc, since I broke it a long time ago.

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

    d. Modify *~/bin/krb5/krb5.conf to set your default principal to whatever 
    you want it to be. For example:

        cat krb5.conf | sed s/'default_realm = HPCMP.HPC.MIL'/'default_realm = ARSC.EDU'/ > krb5.conf

    Note: You may find my krb5.conf in config/.

    e. Modify the *~/.ssh/ssh_config* file to store some host defaults.
    For example, I tacked a bunch of little paragraphs like this to my 
    ssh_config:

        Host hookbill
        User holbrook
        Hostname hookbill.arsc.edu

    This means that if I type **ssh hookbill**, ssh will know that I really 
    mean **ssh holbrook@hookbill.arsc.edu**. Handy!

    Note: You may find my ssh_config in config/. You may also find 
    *ssh_config_gen.py*, a simple python script that may make generating a 
    bunch of similar hosts easier.

    f. *(optional)* Either copy the included *gkshell* to ~/bin or make 
    a ln -s to wherever you want to put it. In addition, I included an icon and
    a .desktop file, which may be used for a launcher in Gnome.

    g. I've noticed that a lot of these changes don't take effect until I at
    least log out and back in. I had to reboot anyway, so that's what I did.
    ymmv.

3. To actually use this stuff:

    a. Run *kshell* in a terminal. It's some kinda security sandbox thing that
    they require you to run everything in. Alternately, run the *gkshell*
    script I included, which pops open a gnome-terminal running kshell.

    b. Typetty-type:
        kinit user[@REALM]

    Enter in your password, use the SecurID, etc. This gives you a krb5 
    ticket with the ARSC system for Xty minutes. Changing your default realm 
    means that typing the @REALM part is no longer necessary.

    c. You're almost there!
        ssh host

    Remember, because the ssh_config file was modified, you don't have to type
    the whole shebang anymore! AWESOME

        * ALSO: To tunnel X (of limited utility imo), run
            ssh -XY host

    d. *(optional)* If you're ever wondering about your ticket status, use 
    **klist**. I didn't actually find it that useful, though.

##UPKEEP##

Every once in a while <https://www.hpcmo.hpc.mil/security/kerberos/> uploads
new versions of the krb5 and ossh bundles to their website. Unfortunately,
the bastards don't make automating the download/update process easy, like, at
all, and even worse, they'll release the Windows version and then say, 
"unix versions coming soon!!"  It's pretty irritating. Anyways: If stuff breaks,
check to see if there's a new version (with your javascript-enabled web browser)
and make with the download when it's time to do so.
