# username/project

Replace this paragraph with a concise description of what the command-line application does, who it serves, and why someone would use it.

## Usage

Prefer a direct `deno run` example with no application options and representative output.

```console
$ deno run jsr:@username/project/cli
Hello, world!
```

## Key features

- Replace this item with a user-visible capability.
- Replace this item with another user-visible capability.

## Prerequisites

- **Deno or Nix**: Replace this text with the minimum Deno requirement, or require Nix with flakes enabled for the Nix paths.

## Setup

Document the supported paths. For applications, include Run, Install, and declarative Nix setup when available. For libraries, include dependency setup only.
Choose one supported setup method; only one is required.

### Run without installing

```bash
deno run jsr:@username/project/cli
nix run github:username/project
```

### Install

```bash
deno install --global --name project jsr:@username/project/cli
nix profile add github:username/project
```

### Nix flake

Add the project's overlay and package to `flake.nix`.

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    project.url = "github:username/project";
  };

  outputs = { nixpkgs, project, ... }:
    let
      system = "aarch64-darwin"; # Replace with a supported host system.
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ project.overlays.default ];
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.project ];
      };
    };
}
```

## API

[JSR API reference](https://jsr.io/@username/project/doc)

## Development

For repository structure and development commands, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
