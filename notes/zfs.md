# resources
- [intro](https://web.archive.org/web/20241202092832/https://www.zfshandbook.com/docs/getting-started/introduction)
- [administration](https://web.archive.org/web/20241217012020/https://www.zfshandbook.com/docs/zfs-administration/zpool-administration/)

- [for dummies](https://blog.victormendonca.com/2020/11/03/zfs-for-dummies/)

# notes
zpool manages the data pool
zfs manages data sets/file systems

# cheat sheet
## install `zfs`
```
sudo apt install zfsutils-linux
```

## create a zpool

(use `--force` if vestiges of an old pool remain)
```
zpool create [--force] <poolname>  [mirror] <devicefile1> [<devicefile2> ...]
```

## check zpool status
```
zpool status <poolname>
```

## get list of pools
```
zpool list
```

## check if any pools/datasets are mounted
```
zfs mount
```

## mount a zfs pool
```
zfs mount <pool or dataset name>
```

## unmount a zfs pool
```
zfs unmount <pool or dataset name>
```

## get attached storage devices that might have zfs:
```
lsblk
```

## check zfs status on a drive
```
zfs list /dev/<hard drive file>
```

eg: check for zfs on the mccblk0p2 drive partition
```
zfs list /dev/mmcblk0p2
```
