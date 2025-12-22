#!/bin/bash

# number of copies to save
num_copies=4

# populate env variables
source ../.env

#################################################
# Windows
#################################################
echo "=== Backing up Windows Drive ===" | tee -a ~/Desktop/borg.log
date | tee -a ~/Desktop/borg.log

borg --verbose --progress init -e keyfile pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr
borg --verbose --progress create --stats pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr::$(date +"tumpa2_windows-%Y%m%d-%H%M%S") /media/jpangia/Acer

borg --verbose --progress prune --list --keep-last $num_copies pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr
borg --verbose --progress compact pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr
date | tee -a ~/Desktop/borg.log
echo "=== Done Backing up Windows Drive ===" | tee -a ~/Desktop/borg.log
echo "" | tee -a ~/Desktop/borg.log

#################################################
# More
#################################################
echo "=== Backing up More Drive ===" | tee -a ~/Desktop/borg.log
date | tee -a ~/Desktop/borg.log

borg --verbose --progress init -e keyfile pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-more-dr
borg --verbose --progress create --stats pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-more-dr::$(date +"tumpa2_more-%Y%m%d-%H%M%S") /media/jpangia/Acer

borg --verbose --progress prune --list --keep-last $num_copies pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-more-dr
borg --verbose --progress compact pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-more-dr
date | tee -a ~/Desktop/borg.log
echo "=== Done Backing up More Drive ===" | tee -a ~/Desktop/borg.log
echo "" | tee -a ~/Desktop/borg.log


#################################################
# Kubuntu
#################################################
echo "=== Backing up Kubuntu Drive ===" | tee -a ~/Desktop/borg.log
date | tee -a ~/Desktop/borg.log

borg --verbose --progress init -e keyfile pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-kubuntu-dr
borg --verbose --progress create --stats pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-kubuntu-dr::$(date +"tumpa2_kubuntu-%Y%m%d-%H%M%S") /media/jpangia/Acer

borg --verbose --progress prune --list --keep-last $num_copies pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-kubuntu-dr
borg --verbose --progress compact pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-kubuntu-dr
date | tee -a ~/Desktop/borg.log
echo "=== Done Backing up Kubuntu Drive ===" | tee -a ~/Desktop/borg.log
echo "" | tee -a ~/Desktop/borg.log
