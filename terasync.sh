#!/bin/bash

echo "#####################################################################"
echo "Package: terasync"
echo "Version: 0.1"
echo "Priority: optional"
echo "Maintainer: Shakil Islam <shakil.islam@gmail.com>"
echo "Depends: rsync, bash"
echo "Description: A multi-threaded rsync script to copy large files."
echo "This script was tested on my home Ethernet Over Power 1GB link and"
echo "My transfer maxed at ~920MBps speed copying multiple large"
echo "files ~210GB in total"
echo "#####################################################################\n\n\n"

# Define source, target, maxdepth and cd to source

echo "###############  Step 1  ###############"
echo "Enter Source directory including hostname if any"
echo "i.e. username@hostname:/mnt/mysrouce"
read -p ">_: " source
echo "\n##################################"
echo "Defined Source directory : $source"
# source="/tmp/source"
echo "##################################\n"


echo "###############  Step 2  ###############"
echo "Enter Target directory including hostname if any"
echo "i.e. username@hostname:/mnt/mytarget"
read -p ">_: " target
echo "\n##################################"
echo "Defined Target Directory: $target"
# target="/tmp/target"
echo "##################################\n"

echo "###############  Step 3  ###############"
echo "Enter level of directories you want to copy"
echo "i.e. numerical value"
read -p ">_: "  depth
echo "\n##################################"
echo "Defined depth level directories to copy: $depth"
# depth=1
echo "##################################\n"

cd "${source}"


# Set the maximum number of concurrent rsync threads
echo "###############  Step 4  ###############"
echo "How many threads you want to open?"
echo "i.e. Numerical value"
read -p ">_: "  maxthreads
echo "\n##################################"
echo "Defined maximum connections we are going to open: $maxthreads"
# maxthreads=30
echo "##################################\n"

echo "\n###############  Starting Copy, please be patient  ###############\n"




# How long to wait before checking the number of rsync threads again
sleeptime=5

# Find all folders in the source directory within the maxdepth level
find . -maxdepth ${depth} -type d | while read dir
do
        # Make sure to ignore the parent folder
        if [ `echo "${dir}" | awk -F'/' '{print NF}'` -gt ${depth} ]
        then
                # Strip leading dot slash
                subfolder=$(echo "${dir}" | sed 's@^./@@g')
                if [ ! -d "${target}/${subfolder}" ]
                then
                        # Create destination folder and set ownership and permissions to match source
                        mkdir -p "${target}/${subfolder}"
                        chown --reference="${source}/${subfolder}" "${target}/${subfolder}"
                        chmod --reference="${source}/${subfolder}" "${target}/${subfolder}"
                fi
                # Make sure the number of rsync threads running is below the threshold
                while [ `ps -ef | grep -c [r]sync` -gt ${maxthreads} ]
                do
                        echo "Sleeping ${sleeptime} seconds"
                        sleep ${sleeptime}
                done
                # Run rsync in background for the current subfolder and move one to the next one
                nohup rsync -a "${source}/${subfolder}/" "${target}/${subfolder}/" </dev/null >/dev/null 2>&1 &
        fi
done

# Find all files above the maxdepth level and rsync them as well
find . -maxdepth ${depth} -type f -print0 | rsync -a --files-from=- --from0 ./ "${target}/"

