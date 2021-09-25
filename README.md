# terasync
Multi Threaded rsync script that theoratically can copy to any max speed


<pre>Package: terasync
Version: 0.1
Priority: optional
Maintainer: bitofsecurity@github
Depends: rsync, bash
Description: A multi-threaded rsync script to copy large files.
This script was tested on my home Ethernet Over Power 1GB link and
My transfer maxed at ~920MBps speed copying multiple large
files ~210GB in total</pre>


Simply create a file terasync.sh in your home directory and use "sh terasync.sh" to run it. The script will explain rest of the steps.

<pre>==================================================================================================================
root@ubuntu18:~# sh terasync.sh
#####################################################################
Package: terasync
Version: 0.1
Priority: optional
Maintainer: bitofsecurity@github
Depends: rsync, bash
Description: A multi-threaded rsync script to copy large files.
This script was tested on my home Ethernet Over Power 1GB link and
My transfer maxed at ~920MBps speed copying multiple large
files ~210GB in total
#####################################################################



###############  Step 1  ###############
Enter Source directory including hostname if any
i.e. username@hostname:/mnt/mysrouce
>_: /sbin

##################################
Defined Source directory : /sbin
##################################

###############  Step 2  ###############
Enter Target directory including hostname if any
i.e. username@hostname:/mnt/mytarget
>_: /tmp

##################################
Defined Target Directory: /tmp
##################################

###############  Step 3  ###############
Enter level of directories you want to copy
i.e. numerical value
>_: 123

##################################
Defined depth level directories to copy: 123
##################################

###############  Step 4  ###############
How many threads you want to open?
i.e. Numerical value
>_: 123

##################################
Defined maximum connections we are going to open: 123
##################################


###############  Starting Copy, please be patient  ###############

root@ubuntu18:~#
</pre>
