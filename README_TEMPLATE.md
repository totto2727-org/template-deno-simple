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

### Permission policy

Document the permissions required by the completed application before listing its run and install commands.
For each permission, state its purpose, exact resource scope, and whether it is required or only needed for an optional feature.
If no runtime permissions are required, state that explicitly and omit permission flags, as in the commands below.

| Permission                                             | Allowed resources                                                   | Purpose                          | Required or optional      |
| ------------------------------------------------------ | ------------------------------------------------------------------- | -------------------------------- | ------------------------- |
| Replace with each required permission, or state `None` | Exact paths, hosts, environment variable names, or executable names | Why the application needs access | Which feature requires it |

- Grant only the permissions the application needs, scoped where possible, such as `--allow-read=/path/to/input`, `--allow-net=api.example.com`, or `--allow-env=API_KEY`.
- Put the same required permission flags before the package specifier in both `deno run` and `deno install --global` commands below, and keep the Usage example consistent.
- `deno install --global` records those flags in the installed launcher for subsequent runs. Reinstall the command when changing its permission policy.
- Do not use `-A` / `--allow-all` or unrestricted permission categories as the default. Explicitly justify subprocess or native-library access because it can bypass Deno's sandbox.
- For unattended execution, document `--no-prompt` together with the required grants so missing permissions fail instead of requesting interactive approval.
- If the Nix installation path is retained, document the permissions granted by its launcher as well. Nix installation does not automatically grant Deno runtime permissions.

See the [Deno permissions guide](https://docs.deno.com/runtime/fundamentals/security/) and [global installation reference](https://docs.deno.com/runtime/reference/cli/install/#deno-install---global-package_or_url).

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

### `project`

Replace this text with the command's caller-visible behavior, inputs, outputs, exit statuses, and failure contract.
If a complete inline reference would be too large, replace this section with a link to a substantive guide under `docs/`.

```console
$ project
replace-with-representative-output
```

## Development

For repository structure and development commands, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
