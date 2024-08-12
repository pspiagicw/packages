{
  description = "Custom `groom` flake to use across projects";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};

    groom = pkgs.buildGoModule rec {
      name = "groom";
      src = pkgs.fetchFromGitHub {
        owner = "pspiagicw";
        repo = "groom";
        rev = "3fd54797db3a614cbc3fa43f3e29a152aa01ffde";
        sha256 = "O37ciBvtbuZX3KNVSg7ZG02o+b0PCQ2K8hJoyo2hPsY=";
      };

      vendorHash = "sha256-r0ttcRQscZFrY69+EBFRLAlWgmKUXBFanQtX1OWvm48=";
    };
  in {
    packages.x86_64-linux.groom = groom;
  };
}
