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
ssh-keygen -t ed25519 -f <path to output private key file> -C "some comment probably with your email"
# enter the key passphrase in the prompts and set that value to the BORG_SSH_KEY_PASSWD variable in `.env`
ssh-copy-id <user>@<server-hostname>
TODO: finish the hardening notes
```

set up the venv with the dependencies
```
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
```


If this is the first time, run `main.py init <fill in the rest>` to create a new repository



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
see [issues](https://github.com/jpangia/borg-backup-infra/issues)

# Potential future features?
- extract and mount commands in the python script