# Changelog

## [Unreleased]

### Fixed

- `unpin install util-linux` now creates the commands. In the v2.42-1 release
  it created only `util-linux` itself: the list of program names never made it
  into the published binary, so `mount`, `lsblk`, `dmesg`, `fdisk` and the
  other 120-odd were installed nowhere.
- `agetty` and `eject -u` ran the real `/bin/login` and `/bin/umount`. The
  v2.42-1 binary had two paths into the machine that built it baked in — it
  tried to run `login` and `umount` from inside that machine's store, which
  does not exist on your computer, so both simply found nothing. Those are the
  conventional locations again, the same defaults upstream ships.
- The binary no longer carries a path into the machine that built it: the
  terminfo directory of that machine is gone too.
- `setarch` offered `i386` and `x86_64` on every processor, where only an x86
  build answers to them. They are announced where they work.

### Changed

- The 14 section-3 pages, which document the libuuid and libblkid C libraries
  rather than any program in here, are no longer embedded — as this README had
  said all along. The 129 that remain are the programs' pages and the
  config-file pages (`fstab`, `terminal-colors.d`, …).
- Built by the same compiler as the rest of the catalog. The binary grew from
  3.57 MB to 9.91 MB, which is code, not embedded data. Checked on Linux
  x86_64 and arm64: `lsblk`, `lscpu`, `cal`, `hexdump`, `uuidgen` and `dmesg`
  all run, and `--unpin-program=` reaches every announced name.
