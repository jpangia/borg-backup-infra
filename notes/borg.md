docs: https://borgbackup.readthedocs.io/en/stable/quickstart.html

# Useful Commands
`init`: create a __repository__ 

`create`: write a backup to an __archive__

`extract`: extract an archive into the current directory

`delete`: delete an archive (but don't free its space)

`compact`: recover disk space from deleted archives

# Useful flags
- `--progress`
- `--list`
- `-v` or `--info`: gives info logging level: includes info, warnings, errors, and critical errors. make all commands run with this
- `borg create -s`: gives stats for the backup creation

# Terms
- archive
  - a single backup
- checkpoint
  - a partially complete backup that was interrupted
- repository
  - collections of related archives. If the same directory is in two archives, and has not changed between the two archives, then the later archive will just contain a reference to the copy of the directory in the other archive

# Encryption Modes
per the warning block in [this section](https://borgbackup.readthedocs.io/en/stable/quickstart.html#repository-encryption):
> Make a backup copy of the key file (keyfile mode) or repo config file (repokey mode) 

`repokey` encryption mode stores the key in a repo config file, and `keyfile` mode stores the key in a key file

# Remote Repositories
https://borgbackup.readthedocs.io/en/stable/quickstart.html#remote-repositories

access a remote host using:
~~`borg <command> user@hostname:/path/to/repo`~~
this should include port number, since I change the port number 

## Restricting SSH Key usage:
Below is an example of an ssh working key restriction. This is placed in the `authorized_keys` file.

Note especially that the `command` string and the `restrict` keyword has no spaces between them and the comma: 
```
command="borg serve --restrict-to-path /home/pi/borg-test",restrict ssh-ed25519 AAAA[...]
```

If this restrict command is malformed, then ssh will just report `Remote: pi@<address>: Permission denied (publickey).`

# Reference Material
- [Borg-specific Environment Variables](https://borgbackup.readthedocs.io/en/stable/usage/general.html#environment-variables)

# Command notes
## `borg list`
checkpoints are not automatically included. you pass the `--consider-checkpoints` flag to get them to be listed

## `borg prune`
checkpoints are removed by `borg prune` automatically unless they are the latest archive


# cheat sheet:
intialize a remote repository with `keyfile` encryption, progress reporting, and info logging
```
borg --verbose --progress init -e keyfile pi@borg-pi:/home/pi/borg-test
```
NOTE: the directory that you are trying to initialize as a repository must be empty

export the key file for a repository
```
borg key export pi@borg-pi:/home/pi/borg-test
```

export key file in a printing-appropriate format [!use this one!]:
```
borg key export --paper pi@borg-pi:/home/pi/borg-test
```
(this prints formatted bytes with instructions on how to import the key)

create an archive named `test2` (after the `::`) of the folder in `$CWD/test2` in the user `pi` on system named `borg-pi` in my `~/.ssh/config`:
```
borg --verbose --progress create --stats pi@borg-pi:/home/pi/borg-test::test2 ./test2
```

check the consistency of the repo at `borg-pi:/home/pi/borg-test`
```
borg --verbose --progress check pi@borg-pi:/home/pi/borg-test
```

bring a broken repository into a state that Borg can mount. Doesn't use parity to recover files (can specify an archive path to fix an archive):
```
borg --verbose --progress check --repair pi@borg-pi:/home/pi/borg-test
```

delete an archive and recover its space:
```
borg --verbose --progress delete pi@borg-pi:/home/pi/borg-test::test2
borg --verbose --progress compact pi@borg-pi:/home/pi/borg-test
```

delete a whole repository:

(deletes the repository folder too)
```
borg --verbose --progress delete pi@borg-pi:/home/pi/borg-test
```

restore folder `test2` from an archive:
```
# in parent folder of `test2`
borg --verbose --progress extract pi@borg-pi:/home/pi/borg-test::test2
```

dry run of pruning down to the last 3 backups:
```
borg --verbose --progress prune --list --dry-run --keep-last 3 pi@borg-pi:/home/pi/borg-test   
```

mount an archive named `test2` to `~/mount/borg-test`:
```
borg --verbose --progress mount pi@borg-pi:/home/pi/borg-test::test2 ~/mount/borg-test
```

unmount from `~/mount/borg-test`:
```
borg --verbose --progress umount ~/mount/borg-test
```

list archives including checkpoints:
```
borg list --consider-checkpoints pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr
```

## back up my windows drive
```
borg --verbose --progress init -e keyfile pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr
borg --verbose --progress create --stats pi@borg-pi:/home/pi/mnt/blomp-nas/tumpa2-windows-dr::$(date +"tumpa2_windows-%Y%m%d-%H%M%S") /media/jpangia/Acer
```