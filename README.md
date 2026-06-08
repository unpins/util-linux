# util-linux

[util-linux](https://github.com/util-linux/util-linux) — a single self-contained binary providing 122 programs (`mount`, `umount`, `blkid`, `findmnt`, `lsblk`, `dmesg`, `fdisk`, `cfdisk`, …), built natively for Linux.

[![CI](https://github.com/unpins/util-linux/actions/workflows/util-linux.yml/badge.svg)](https://github.com/unpins/util-linux/actions)
![Linux](https://img.shields.io/badge/Linux-✓-success?logo=linux&logoColor=white)

Part of the [unpins](https://unpins.org) catalog; install it with [`unpin`](https://github.com/unpins/unpin): `unpin install util-linux`.

Linux-only: util-linux talks to Linux-specific syscalls (mount, namespaces, init_module-adjacent, …), block-device ioctls, and parses `/proc` / `/sys` extensively.

## Usage

Run a program with [unpin](https://github.com/unpins/unpin):

```bash
unpin util-linux lsblk
unpin util-linux mount /dev/sda1 /mnt
unpin util-linux blkid /dev/sda1
unpin util-linux fdisk -l
```

To install the programs onto your PATH:

```bash
unpin install util-linux
```

`unpin install util-linux` also creates the 122 programs as commands — `mount`, `umount`, `blkid`, `lsblk`, `fdisk`, … (full list: `unpin info util-linux`).

## Man pages

The program man pages (126 — sections 1, 5, and 8) are embedded in the binary; read one with `unpin man util-linux <program>`, e.g. `unpin man util-linux mount`. The section-3 libuuid/libblkid C-library API pages are dropped — this package ships the programs, not the dev libraries.
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

