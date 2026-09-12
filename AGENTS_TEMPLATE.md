# username/project

## Repository structure

```text
.github/workflows/  Validation and optional publishing workflows
deno.json           Package identity, exports, and Deno tasks
flake.nix           Development shell and optional package outputs
package.nix         Optional installable Nix package
src/main.ts         Command-line application entry point
src/*_test.ts       Tests
```

Replace the sample paths with the initialized project's actual source and test layout.

## Development commands

### Execution rules

- Run commands from the repository root.
- Enter the environment with `nix develop` before running project tasks.
- Use Deno for source formatting, linting, type checking, testing, and execution.
- Keep Nix package validation separate from source tasks and normal CI.
- Keep `AGENTS.md` as the canonical agent document without a `CLAUDE.md` alias.

### Standard tasks

- `nix develop`: Enter the pinned development environment.
- `deno task fix`: Format TypeScript source and apply supported lint fixes.
- `deno task check`: Verify formatting, lint, and discovered TypeScript types.
- `deno task test`: Run Deno tests.
- `deno task start`: Run the command from source.
- `deno task dev`: Run the command and watch source changes.
- `deno task ci`: Run source checks, tests, command execution, and a JSR publish dry run without Nix package validation.
- `nix build .#project`: Build the optional Nix package independently.
- `nix run .`: Run the optional Nix package independently.

## Architecture

### CLI boundaries

- Keep the command entry point small and separate reusable application logic from side effects.
- Propagate errors to the command boundary and define caller-visible output and exit-status behavior.
- Cover externally observable command behavior with focused tests.

### Nix packaging

- Keep package.nix, package outputs, and the overlay for distributable CLI applications so every documented Nix path remains valid; remove them only when the project is no longer distributed as a CLI.
- When adding runtime dependencies, bundle or vendor them reproducibly rather than resolving them from the network at runtime.
- Keep Nix package validation separate from normal CI.

## Development tools

- **Deno**: Uses deno.json for runtime tasks, formatting, type checks, tests, and JSR exports.
- **Nix flakes**: Pin the development toolchain and optionally expose the package and overlay.

## Package-specific rules

- Replace this section with repository-specific invariants and remove placeholder guidance before handoff.
- Keep README Usage centered on a representative command invocation with no application options when possible.
- Keep README Setup complete: present direct `deno run` and `nix run`, installed `deno install --global` and `nix profile add`, and a declarative `flake.nix` example using `overlays.default` as mutually exclusive choices; state that only one setup method is required.
- Remove unsupported acquisition paths before publishing the README. For libraries, document dependency setup and every public export instead of CLI installation routes.
- Inspect the canonical registry API documentation when the project exposes a library. Link a maintained API index when available; otherwise provide complete inline coverage or a substantive guide.
- Keep semicolons disabled, single quotes enabled, line width 120, and Markdown prose unwrapped.
- Keep exports and publication patterns in deno.json aligned with the public API. Commit deno.lock when external dependencies are introduced.
- Update flake.lock when Nix inputs change.
- Keep publishing workflows disabled until repository-linked OIDC publication is configured. Use no long-lived registry tokens.
- Keep shared totto2727-org/monorepo actions on @main and review the pinned third-party actions before enabling publication.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
