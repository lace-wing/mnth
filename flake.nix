{
  description = "My New Theme Helper (MNTH, subject to change)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs;
          [
            elixir
            erlang
            fswatch # live-reload
          ]
          ++ lib.optionals stdenv.isLinux [
            inotify-tools # Linux-specific file watching
          ];

        shellHook = ''
          # local directories for Hex and Rebar data
          mkdir -p .nix-mix
          mkdir -p .nix-hex
          export MIX_HOME=$PWD/.nix-mix
          export HEX_HOME=$PWD/.nix-hex
          export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH

          echo "--- MNTH Environment ---"
          echo "Elixir $(elixir --version | grep 'Elixir' | awk '{print $2}')"
          echo "Erlang $(erlangal -eval 'io:format("~s", [erlang:system_info(otp_release)]), halt().' -noshell)"
          echo "Run 'mix deps.get' to begin."
        '';
      };
    });
}
