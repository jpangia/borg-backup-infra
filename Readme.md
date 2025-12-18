# Description
fill this in later (how long will this be here, I wonder?)

# Setup

## client

### env file
define a `.env` file at the repository root directory of the form:
```
export BORG_SSH_KEY_PASSWD=<ssh key passphrase>
export BORG_PASSPHRASE=<backup encryption password>
export SSH_ASKPASS="path to a script that echoes SSH_BORG_PASSWD"
export SSH_ASKPASS_REQUIRE=force
```

### Ubuntu
#### install borg:
```
sudo apt install borgbackup
```

create an ssh keypair for between the client and server
```
[ssh key gen commands here]
```

If this is the first time, run `pyborg.py init <fill in the rest>` to create a new repository

## server
### RaspberyPiOS

#### Set up the pi
- create the raspberry pi with `rpi-imager`
- get it set up on your network and get the ip address of it for later
- enable running sshd on boot by running `sudo systemctl enable ssh` in the pi

#### install borg
```
sudo apt install borgbackup
```

#### modify ssh `authorized_keys` file to restrict the ssh key to only allow `borg serve` to run.

This is done by adding a line like this to `authorized_keys`:
```
command="borg serve --restrict-to-path /path/to/repo",restrict <ssh public key string>
```
(there should not be a space before or after the comma)

#### harden the pi a little bit with these steps:
adding the following lines to `/etc/ssh/sshd_config`:
```
Port <some port other than port 22>
PasswordAuthentication no
PermitEmptyPasswords no
X11Forwarding no
```
(they should be in commented-out lines in the default generation of `sshd_config`)

# Files
- `./cfg.json`: stores assorted state information for the backups like remote server ip and if the last run was successful (this should be `.gitignore`d)
- `./src/piborg.py`: the file to run the scripts (this might move)
- `./src/borg.py`: functions for running borg commands
- `./src/config.py`: funtions for config-related operations
- `./src/util.py`: functions for common operations

# BEFORE RUNNING:
run 
```
source .env
```

it populates the necessary env variables for simple connection to the borg

# TODO
- [ ] add an fstab entry to mount the zfs pool

- [ ] in script main: error, log to the config, and write a file to the desktop if the ip of the server changed or the server is unreachable
- [ ] make init check for if the repo exists
- [ ] backup script should add the key to ssh_agent at start. hopefully we can pass the password programatically to the ssh agent
- [ ] write an error log file to a configurable file location if something goes wrong (default to writing error to the desktop)

# left off doing:
next thing: run a backup of the windows drive with the `-s` switch
- create the zfs pool on the hard drive
- mount the zfs drive to the pi
- make folder in zfs drive for each drive
- make repo for windows backup
- run backup

# Potential future features?
- extract and mount commands in the python script