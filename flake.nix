{
  description = "util-linux as a single self-contained binary";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  # Linux-only multicall: util-linux ships ~118 separate static binaries
  # (mount/umount/blkid/fdisk/cfdisk/agetty/setarch/dmesg/lsblk/…), none
  # sharing a multicall entry point. Talks to Linux-specific syscalls and
  # parses /proc, /sys extensively; nixpkgs `meta.platforms` is *-linux only.
  outputs = { self, unpins-lib }:
    unpins-lib.lib.mkStandaloneFlake {
      inherit self;
      name = "util-linux";
      # upstream COPYING default is GPL-2.0-or-later for the programs; the LGPL libs
      # (libmount/libblkid/libuuid) and a few BSD/public-domain files don't govern
      # the multicall binary.
      license = "GPL-2.0-or-later";
      linuxOnly = true;

      # Smoke floor: bare `util-linux` (no applet) prints usage, so probe a
      # representative applet through the `--unpin-program=` selector. Match a
      # dmesg-specific `--help` line rather than `--version`: util-linux tools
      # print the libc `program_invocation_short_name` (the process argv[0],
      # i.e. `util-linux`), which the `--unpin-program=` dispatcher can't
      # rewrite — so `dmesg --version` reads `util-linux from util-linux`, not
      # `dmesg from …`. `dmesg --help` prints dmesg's own text and exits 0,
      # proving the applet dispatched (same shape as shadow's chage --help).
      smoke = [ "--unpin-program=dmesg" "--help" ];
      smokePattern = "Display or control the kernel ring buffer";

      # Build via the unpin-llvm engine + emit a bitcode multicall module. On
      # Linux the engine compiles plain pkgsStatic.util-linux (every tool is its
      # own upstream binary) to bitcode and the standalone self-folds them into
      # one `util-linux` binary. The old X+Z objcopy/source-rename fold in
      # ./multicall.nix can't run on the engine's -flto bitcode objects, so it's
      # dropped in favour of the bitcode multicall hook, which captures each
      # program's link and emits module.bc. Pure C — no requires.cxx.
      #
      # The program `name` is the LINKED executable basename. argv[0]-dispatch
      # aliases (setarch → linux32/linux64/uname26/i386/x86_64; last → lastb;
      # hexdump → hd) are listed under their real program, not as separate
      # programs.
      engine = "unpin-llvm";
      multicall = {
        programs = [
          { name = "addpart"; }
          { name = "agetty"; }
          { name = "bits"; }
          { name = "blkdiscard"; }
          { name = "blkid"; }
          { name = "blkpr"; }
          { name = "blkzone"; }
          { name = "blockdev"; }
          { name = "cal"; }
          { name = "cfdisk"; }
          { name = "chcpu"; }
          { name = "chmem"; }
          { name = "choom"; }
          { name = "chrt"; }
          { name = "colcrt"; }
          { name = "colrm"; }
          { name = "column"; }
          { name = "copyfilerange"; }
          { name = "coresched"; }
          { name = "ctrlaltdel"; }
          { name = "delpart"; }
          { name = "dmesg"; }
          { name = "eject"; }
          { name = "enosys"; }
          { name = "exch"; }
          { name = "fadvise"; }
          { name = "fallocate"; }
          { name = "fdisk"; }
          { name = "fincore"; }
          { name = "findfs"; }
          { name = "findmnt"; }
          { name = "flock"; }
          { name = "fsck"; }
          { name = "fsck.cramfs"; }
          { name = "fsck.minix"; }
          { name = "fsfreeze"; }
          { name = "fstrim"; }
          { name = "getino"; }
          { name = "getopt"; }
          { name = "hardlink"; }
          { name = "hexdump"; aliases = [ "hd" ]; }
          { name = "hwclock"; }
          { name = "ionice"; }
          { name = "ipcmk"; }
          { name = "ipcrm"; }
          { name = "ipcs"; }
          { name = "irqtop"; }
          { name = "isosize"; }
          { name = "kill"; }
          { name = "last"; aliases = [ "lastb" ]; }
          { name = "ldattach"; }
          { name = "logger"; }
          { name = "look"; }
          { name = "losetup"; }
          { name = "lsblk"; }
          { name = "lsclocks"; }
          { name = "lscpu"; }
          { name = "lsfd"; }
          { name = "lsipc"; }
          { name = "lsirq"; }
          { name = "lslocks"; }
          { name = "lslogins"; }
          { name = "lsmem"; }
          { name = "lsns"; }
          { name = "mcookie"; }
          { name = "mesg"; }
          { name = "mkfs"; }
          { name = "mkfs.bfs"; }
          { name = "mkfs.cramfs"; }
          { name = "mkfs.minix"; }
          { name = "mkswap"; }
          { name = "more"; }
          { name = "mount"; }
          { name = "mountpoint"; }
          { name = "namei"; }
          { name = "nologin"; }
          { name = "nsenter"; }
          { name = "partx"; }
          { name = "pipesz"; }
          { name = "pivot_root"; }
          { name = "prlimit"; }
          { name = "readprofile"; }
          { name = "rename"; }
          { name = "renice"; }
          { name = "resizepart"; }
          { name = "rev"; }
          { name = "rfkill"; }
          { name = "rtcwake"; }
          { name = "script"; }
          { name = "scriptlive"; }
          { name = "scriptreplay"; }
          { name = "setarch"; aliases = [ "linux32" "linux64" "uname26" "i386" "x86_64" ]; }
          { name = "setpgid"; }
          { name = "setpriv"; }
          { name = "setsid"; }
          { name = "setterm"; }
          { name = "sfdisk"; }
          { name = "sulogin"; }
          { name = "swaplabel"; }
          { name = "swapoff"; }
          { name = "swapon"; }
          { name = "switch_root"; }
          { name = "taskset"; }
          { name = "uclampset"; }
          { name = "ul"; }
          { name = "umount"; }
          { name = "unshare"; }
          { name = "utmpdump"; }
          { name = "uuidd"; }
          { name = "uuidgen"; }
          { name = "uuidparse"; }
          { name = "waitpid"; }
          { name = "wall"; }
          { name = "wdctl"; }
          { name = "whereis"; }
          { name = "wipefs"; }
          { name = "write"; }
          { name = "zramctl"; }
        ];
      };

      # linuxOnly + no windowsBuild → the engine path is the only build reached.
      # Engine: plain pkgsStatic.util-linux compiled to bitcode and self-folded
      # into one binary by the standalone. asciidoctor builds the *.adoc man
      # pages (build-host only); --disable-poman drops the po4a-translated pages
      # (which fail in the sandbox). withMan harvests $out/share/man into the
      # embedded ZIP.
      build = pkgs:
        pkgs.pkgsStatic.util-linux.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ])
            ++ [ pkgs.buildPackages.asciidoctor ];
          configureFlags = (old.configureFlags or [ ]) ++ [ "--disable-poman" ];
          # The bitcode multicall hook appends a per-program postBuild block; at
          # 118 programs the generated postBuild (~180KB) exceeds the kernel's
          # MAX_ARG_STRLEN (128KB per env string) and the build dies with
          # "executing bash: Argument list too long" before any phase runs.
          # structuredAttrs ships attrs via .attrs.json instead of the
          # environment, sidestepping the per-string env limit.
          __structuredAttrs = true;
        });
    };
}
