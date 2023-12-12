{ pkgs, lib, deno2nix, ... }:

{ name, input }:

let
  inherit (pkgs) stdenv;
  inherit (deno2nix.internal) mkDepsLink;
  isDeno = builtins.pathExists "${input}/deno.lock";
in
stdenv.mkDerivation rec {
  inherit name;
  src = input;

  nativeBuildInputs = if isDeno then [ pkgs.deno ] else [];

  buildPhase = ''
    ${
      if isDeno then ''
        export DENO_DIR="$(mktemp -d)"
        ln -s "${mkDepsLink (src + "/deno.lock")}" $(deno info --json | jq -r .modulesCache)
      '' else ""
    }
  '';

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}
