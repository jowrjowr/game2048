{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  inherit (lib) optional optionals;
  elixir = beam.packages.erlangR22.elixir_1_10;
in

mkShell {
  buildInputs = [
    ps
    elixir
    coreutils
    which
    git
    cmake
    nix-prefetch-git
    zlib
    jq
  ];

  # Fix GLIBC Locale
  LOCALE_ARCHIVE = stdenv.lib.optionalString stdenv.isLinux
    "${pkgs.glibcLocales}/lib/locale/locale-archive";
  LANG = "en_US.UTF-8";
  ERL_INCLUDE_PATH="${erlangR22}/lib/erlang/usr/include";

}

