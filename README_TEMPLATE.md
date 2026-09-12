# username/project

Replace this paragraph with the command's purpose and its user-visible outcome.

## Usage

Show one representative installed-command invocation and its actual expected output.

```console
$ project
Hello, world!
```

Replace the sample output when implementing the application.

## Key features

- Replace with the application's user-visible capabilities.

## Prerequisites

- **Deno 2.9 or newer**: Required for the JSR installation path.
- **Nix with flakes enabled**: Required only for a Nix installation path.

## Setup

Choose one supported method below; only one setup method is required.
Remove registry paths until the package is published and remove Nix paths if the CLI flake outputs are removed.

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

```nix
{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    project.url = "github:username/project";
  };

  outputs = { nixpkgs, project, ... }:
    let
      system = "aarch64-darwin"; # Select a supported host system.
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

### `project`

The starter command accepts no defined options, ignores extra arguments, prints `Hello, world!` followed by a newline, and exits successfully.
Replace this description with the completed command's inputs, outputs, exit behavior, and constraints.

### `greet(name = 'world')`

The package root exports a greeting function that returns a string without normalizing the supplied name.

```ts
import { greet } from 'jsr:@username/project'

greet('TypeScript') // 'Hello, TypeScript!'
```

After publishing, inspect JSR's generated API reference and link its canonical API index instead of duplicating it here when it is available.

## Development

See [AGENTS.md](./AGENTS.md) for project structure and developer commands.

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
