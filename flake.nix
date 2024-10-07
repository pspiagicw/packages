{
  description = "Custom flake for all custom packages";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    pkgs = {
      x86_64-linux = import nixpkgs {system = "x86_64-linux";};
      aarch64-linux = import nixpkgs {system = "aarch64-linux";};
    };

    groom = {system}:
      pkgs.${system}.buildGoModule rec {
        name = "groom";
        src = pkgs.${system}.fetchFromGitHub {
          owner = "pspiagicw";
          repo = "groom";
          rev = "3fd54797db3a614cbc3fa43f3e29a152aa01ffde";
          sha256 = "O37ciBvtbuZX3KNVSg7ZG02o+b0PCQ2K8hJoyo2hPsY=";
        };

        vendorHash = "sha256-r0ttcRQscZFrY69+EBFRLAlWgmKUXBFanQtX1OWvm48=";
      };

    kato = {system}:
      pkgs.${system}.buildGoModule rec {
        name = "kato";
        src = pkgs.${system}.fetchFromGitHub {
          owner = "pspiagicw";
          repo = "kato";
        };
      };
  in {
    packages.x86_64-linux.groom = groom {system = "x86_64-linux";};
    packages.x86_64-linux.kato = kato {system = "x86_64-linux";};
    packages.aarch64-linux.groom = groom {system = "aarch64-linux";};
    packages.aarch64-linux.kato = kato {system = "aarch64-linux";};
  };
}
