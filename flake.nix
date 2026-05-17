{
  description = "Standalone build of util-linux";

  nixConfig = {
    extra-substituters = [ "https://unpins.cachix.org" ];
    extra-trusted-public-keys = [ "unpins.cachix.org-1:DDaShjbZ8VvcqxeTcAU3kV9vxZQBlyb7V/uLBHfTynI=" ];
  };

  inputs.unpins-lib.url = "github:unpins/nix-lib";

  outputs = { self, unpins-lib }:
    unpins-lib.lib.mkStandaloneFlake {
      inherit self;
      name = "util-linux";
      # Talks to Linux-specific syscalls and parses /proc, /sys extensively;
      # nixpkgs `meta.platforms` is *-linux only.
      linuxOnly = true;
    };
}
