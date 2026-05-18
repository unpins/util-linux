{
  description = "Standalone build of util-linux";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  # Linux-only multicall (122 applets including mount/umount/blkid/fdisk/
  # cfdisk/agetty/setarch) built via the post-link recipe in
  # ./multicall.nix — same ld -r + objcopy --redefine-sym pattern as
  # e2fsprogs / procps / shadow / findutils, with Makefile/automake
  # parsing on top to discover the applet list automatically.
  # Talks to Linux-specific syscalls and parses /proc, /sys extensively;
  # nixpkgs `meta.platforms` is *-linux only.
  outputs = { self, unpins-lib }:
    unpins-lib.lib.mkStandaloneFlake {
      inherit self;
      name = "util-linux";
      linuxOnly = true;
      build = pkgs:
        import ./multicall.nix {
          lib = pkgs.lib // unpins-lib.lib;
        } pkgs;
    };
}
