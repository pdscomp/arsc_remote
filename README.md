###ABOUT:###

I've been using ssh and typical Linux package management for a while, but
HPCMP's ssh/kerberos system (which I was using with [ARSC](http://www.arsc.edu)
threw me for a loop.  If you want to remotely log into their computers, you
*must* use HPCMP's versions of ssh and Kerberos. The standard versions of
Putty, ossh and krb5 that you can download from their respective sites and/or
yum, apt-get, etc. Will *not* work. Moreover, you can't compile yourself and
must download HPCMP's binaries which makes the linux action that much more
irritating, and potentially confusing for the typical linux user. At least, I
know I was confused.

arsc_remote was meant to be a set of tools that makes using the HPCMP krb and 
ssh bundles for *nix (Windows is pretty easy as-is if you don't want X-
tunneling) less of a pain to use.  As fate would have it, however, it instead 
turned out to be a small handfull of tools combined with a README that 
describes how I set everything up for myself. My goal is to describe how to get
everything rolling with the least amount of heartache.

###TODO:###

* Find some way to automate the krb5/ssh downloads.
* Test out scp, etc, since I broke it a long time ago.

###LINUX:###

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
    In fact, the ~/.ssh/config that comes with hpcmp's ssh has options that 
    *break* regular ssh. If you get configuration errors, try **which ssh** to
    check for that issue.

    c. To implement all this, I just added the following to my .bash_profile:

        PATH=$HOME/bin/krb5/bin:$HOME/bin:$PATH; export PATH
        KRB5_CONFIG=$HOME/bin/krb5/krb5.conf; export KRB5_CONFIG

    d. Modify *~/bin/krb5/krb5.conf to set your default principal to whatever 
    you want it to be. For example:

        cat krb5.conf | sed s/'default_realm = HPCMP.HPC.MIL'/'default_realm = ARSC.EDU'/ > krb5.conf

    Note: You may find my krb5.conf in config/.

    e. Modify the *~/.ssh/config* file to store some host defaults.
    For example, I tacked a bunch of little paragraphs like this to my 
    ssh_config:

        Host hookbill
        User holbrook
        Hostname hookbill.arsc.edu

    This means that if I type **ssh hookbill**, ssh will know that I really 
    mean **ssh holbrook@hookbill.arsc.edu**. Handy!

    Note: You may find my ssh_config in config/. You may also find 
    *ssh_config_gen.py*, a simple python script that may make generating a 
    bunch of similar hosts easier. Note that, while there are a lot of files in
    ~/.ssh (for me, anyway) with "config" in their names (and the example
    config file is named ssh_config), that ssh looks for **~/.ssh/config** in
    particular (unless otherwise specified at the command line).

    f. *(optional)* Either copy the included *gkshell* to ~/bin or make 
    a ln -s to wherever you want to put it. In addition, I included an icon and
    a .desktop file, which may be used for a launcher in Gnome. Finally, 
    *gkshell* has gnome-terminal look for a custom profile named "krb5," so you
    can make your kshell window look different, if you like.

    g. I've noticed that a lot of these changes don't take effect until I at
    least log out and back in. I had to reboot anyway, so that's what I did.
    ymmv.

3. To actually use this stuff:

    a. Run [*kshell*](http://www.afrl.hpc.mil/customer/userdocs/kerberos/man/kshell.html) in a terminal. It's some kinda security sandbox thing that
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

##WINDOWS:##

I hardly use Windows, but I do use it sometimes on other peoples' computers!
So, I did my best to do a quick write-up on how to get it working in Windows.
No guarantees that this is up-to-date or remotely helpful. XD

1. Download and install the client bundle from 
<https://www.hpcmo.hpc.mil/security/kerberos/>. Instead of separate krb5 and
ssh bundles (as is the case with the linux version), HPCMP offers a single
bundle, either as an installer or a
[self-extracting archive](http://www.wikihow.com/Use-7Zip-to-Create-Self-Extracting-excutables).
I downloaded the latter, and installed it on my jumpdrive, but you should be
able to do whichever you feel works best with you. HPCMP cautions to uninstall
the old bundle before you install the new one (if you're updating), but it
seems to be less of an issue with the self-extracting version (which appears to
be portable).

2. Open *krb5.exe*. This should be pretty self-explanatory. Enter your data, and
mash "login."

    > Username: [holbrook] Password: [******] Realm: [ARSC.EDU]  
    > [Change Password]  **[LOGIN]** [????]

    It will prompt you for your security key action, and then you should see a
    scalding-bright green [TICKET} in the window. Now you can close *krb5.exe*. You
    don't need that shit no more.

3. Open *putty.exe*.

    a. *(optional but handy)* Setup:
      * Under "Host Name," type in the name of the computer you want to 
          login to, eg. "mallard.arsc.edu."
      * Click "Connection-->Data" on the left-panel tree. You should see a
          box that says, "Auto-login Username." Type your username in there.
      * Go back to the "Session" panel (click it on the left-panel tree).
          Type a memorable name in the "Saved Sessions" box (eg. "mallard") and
          then mash "Save" next to that.
      * What did that just do? It saved the information that you would type
          every time you want to log into that computer otherwise, and made it
          easy to use next time!

    b. 
      * *If you chose to complete step 3a)*: Double-click the computer's
          entry in the saved sessions list.
      * *If you chose **NOT** to complete step 3a)*: Under "Host Name," type
          in the name of the computer you want to login to, 
          eg. "mallard.arsc.edu," then hit "Connect." Putty will prompt you
          for your username.

    c. *(Optional)* Getting X to work in Putty is tougher in Windows than it is
    in Linux, and as far as I know next to impossible when you're locked in
    userspace. Because I find tunneling X to be of limited utility, I never
    bothered to try it! However, 
    [ARSC's web page on the subject](http://www.arsc.edu/support/howtos/UsingXming.html)
    should be able to get you going.

###UPKEEP:###

Every once in a while <https://www.hpcmo.hpc.mil/security/kerberos/> uploads
new versions of the krb5 and ossh bundles to their website. Unfortunately,
the bastards don't make automating the download/update process easy, like, at
all, and even worse, they'll release the Windows version and then say, 
"unix versions coming soon!!"  It's pretty irritating. Anyways: If stuff breaks,
check to see if there's a new version (with your javascript-enabled web browser)
and make with the download when it's time to do so.
