# util-linux

Standalone build of [util-linux](https://github.com/util-linux/util-linux), shipped as a single multicall binary that dispatches to 122 applets via argv[0] — `mount`, `umount`, `blkid`, `findmnt`, `lsblk`, `dmesg`, `fdisk`, `cfdisk`, `cal`, `hexdump`, `flock`, `agetty`, `sulogin`, `nsenter`, `unshare`, `losetup`, `mkswap`, `swapon`, `swapoff`, `switch_root`, …

[![CI](https://github.com/unpins/util-linux/actions/workflows/util-linux.yml/badge.svg)](https://github.com/unpins/util-linux/actions)
![Linux](https://img.shields.io/badge/Linux-✓-success?logo=linux&logoColor=white)

Part of the [unpins](https://unpins.org) project — native single-binary builds with no third-party runtime dependencies.

Linux-only: util-linux talks to Linux-specific syscalls (mount, namespaces, init_module-adjacent, …), block-device ioctls, and parses `/proc` / `/sys` extensively.

## Usage

The package ships one executable, `util-linux`. `unpin install` materializes per-applet shims (`mount`, `umount`, `blkid`, …) next to the multicall using argv[0] dispatch. To run a command directly without installing, invoke as `util-linux <applet>`:

```bash
util-linux mount /dev/sda1 /mnt
util-linux blkid /dev/sda1
util-linux fdisk -l
util-linux dmesg | tail
```

Or create symlinks named after the commands you want to use as bare names:

```bash
ln -s "$(command -v util-linux)" ~/bin/mount
mount /dev/sda1 /mnt
```

Built-in applets (122): `addpart`, `agetty`, `bits`, `blkdiscard`, `blkid`, `blkpr`, `blkzone`, `blockdev`, `cal`, `cfdisk`, `chcpu`, `chmem`, `choom`, `chrt`, `colcrt`, `colrm`, `column`, `coresched`, `ctrlaltdel`, `delpart`, `dmesg`, `eject`, `enosys`, `exch`, `fadvise`, `fallocate`, `fdisk`, `fincore`, `findfs`, `findmnt`, `flock`, `fsck`, `fsck.cramfs`, `fsck.minix`, `fsfreeze`, `fstrim`, `getopt`, `hardlink`, `hexdump`, `hwclock`, `i386`, `ionice`, `ipcmk`, `ipcrm`, `ipcs`, `irqtop`, `isosize`, `kill`, `last`, `lastb`, `ldattach`, `linux32`, `linux64`, `logger`, `look`, `losetup`, `lsblk`, `lsclocks`, `lscpu`, `lsfd`, `lsipc`, `lsirq`, `lslocks`, `lslogins`, `lsmem`, `lsns`, `mcookie`, `mesg`, `mkfs`, `mkfs.bfs`, `mkfs.cramfs`, `mkfs.minix`, `mkswap`, `more`, `mount`, `mountpoint`, `namei`, `nologin`, `nsenter`, `partx`, `pipesz`, `pivot_root`, `prlimit`, `readprofile`, `rename`, `renice`, `resizepart`, `rev`, `rfkill`, `rtcwake`, `script`, `scriptlive`, `scriptreplay`, `setarch`, `setpgid`, `setpriv`, `setsid`, `setterm`, `sfdisk`, `sulogin`, `swaplabel`, `swapoff`, `swapon`, `switch_root`, `taskset`, `uclampset`, `ul`, `umount`, `uname26`, `unshare`, `utmpdump`, `uuidd`, `uuidgen`, `uuidparse`, `waitpid`, `wall`, `wdctl`, `whereis`, `wipefs`, `write`, `x86_64`, `zramctl`.

## Installation

Install with [unpin](https://github.com/unpins/unpin):

```bash
unpin util-linux
```

Or run without installing:

```bash
unpin run util-linux
```

## Build locally

```bash
nix build github:unpins/util-linux
./result/bin/util-linux blkid -V
```

Or run directly:

```bash
nix run github:unpins/util-linux -- blkid -V
```

The first invocation will offer to add the [unpins.cachix.org](https://unpins.cachix.org) substituter so most pulls come pre-built.

## Manual download

The [Releases](https://github.com/unpins/util-linux/releases) page has standalone binaries for manual download.

## Man pages

The applet man pages (126 — sections 1, 5, and 8) are embedded in the binary; read one with `unpin man util-linux <applet>`, e.g. `unpin man util-linux mount`. The section-3 libuuid/libblkid C-library API pages are dropped — this package ships the CLI applets, not the dev libraries.
