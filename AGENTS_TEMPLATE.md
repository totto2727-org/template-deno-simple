# username/project

## Repository structure

```text
.github/workflows/     Validation and disabled registry/FlakeHub publishing
.envrc                 Optional direnv integration
AGENTS_TEMPLATE.md     Developer guidance for copied projects
README_TEMPLATE.md     End-user documentation for copied projects
deno.json               Package metadata and tasks
flake.nix              Development shell, package, and overlay outputs
flake.lock             Pinned Nix inputs
package.nix            Installable source-based CLI and runtime
src/                   Greeting, CLI entry point, and tests
```

Replace the sample paths with the initialized project's layout and remove the document-template entries after conversion.

## Development commands

### Execution rules

- Run commands from the repository root.
- Use `nix develop` for the pinned environment, or install the toolchain described in README.
- Do not grant blanket -A permissions. The starter application and tests require no extra permissions.
- Use native Deno tasks for source validation and direct Nix commands for package validation.
- Keep semicolons disabled, single quotes enabled, line width 120, and Markdown prose unwrapped.
- Keep `AGENTS.md` as the only canonical agent document. Do not create `CLAUDE.md` in this template family.

### Standard tasks

- `nix develop`: Enter the pinned development shell.
- `nix develop --command nixfmt flake.nix package.nix`: Format the Nix definitions.
- `deno task fix`: Format and apply supported lint fixes.
- `deno task check`: Check formatting, lint, and all discovered TypeScript files.
- `deno task test`: Run all tests.
- `deno task start`: Run the source CLI.
- `deno task dev`: Watch source changes.
- `deno publish --dry-run`: Validate JSR exports and inspect publication contents without publishing.
- `nix build`: Build the installable command.
- `nix run .`: Run the packaged command.
- `nix flake check --all-systems --no-build`: Evaluate every supported system without cross-compiling.

## Architecture

### Command and package

- `src/greet.ts` owns the pure greeting and `src/main.ts` owns standard output.
- `package.nix` uses `writeShellApplication` to install `project` together with Deno and immutable TypeScript sources.
- This source-based Nix package is intentionally dependency-free. When adding runtime dependencies, update it to bundle or vendor them reproducibly rather than resolving packages from the network at runtime.
- `flake.nix` exports `packages.project`, `packages.default`, and `overlays.default` for aarch64-darwin, aarch64-linux, and x86_64-linux.
- JSR exports the greeting module at the package root and the CLI at /cli.
- Source checks and Nix package validation run in separate CI jobs.

Replace the sample-specific details with actual application boundaries and keep its public CLI and exports documented and tested.

## Development tools

- **Deno**: Source execution, formatting, linting, type checks, and tests.
- **Nix flakes**: Pinned development tools, installable CLI, and reusable overlay.
- **direnv (optional)**: Loads `.envrc` after the user explicitly runs `direnv allow`.
- **GitHub Actions**: Source/package validation and opt-in OIDC publication.

## Package-specific rules

- Replace this guidance with the copied project's invariants and remove all placeholders before handoff.
- Keep manifest metadata, command name, Nix package/overlay attributes, and user documentation aligned.
- Preserve Nix acquisition paths while the CLI package is retained.
- Update lockfiles when dependencies or Nix inputs change.

### JSR repository-linked publishing

1. Replace `@username/project`, the version, exports, and publication include list in `deno.json` with the copied project's metadata.
2. Create the scope and package on JSR under an account you control. In the package's settings, link the exact GitHub owner/repository and require GitHub Actions publication where appropriate.
3. Use the GitHub-hosted runner and job-scoped `id-token: write` in `publish.yml`. JSR obtains OIDC authentication from the linked repository automatically. Do not add a JSR token or a `--token` argument.
4. Audit the pinned actions, configure protected release tags, and rename `.github/workflows/publish.yml.disabled` to `publish.yml`.
5. Run `deno task check`, `deno task test`, and `deno publish --dry-run` and review the exact uploaded files. During local work only, add `--allow-dirty` to the dry run if needed; never add it to the publishing workflow.
6. Commit the initialized package and push a protected `v<version>` tag matching `deno.json`. The workflow checks the tag before running `deno publish` with default provenance enabled.

Reference: [JSR GitHub Actions publishing](https://jsr.io/docs/publishing-packages#publishing-from-github-actions).

### FlakeHub rolling publication

- Keep `.github/workflows/flakehub-publish-rolling.yml.disabled` disabled until a copied project explicitly enables publication.
- Use the [official FlakeHub publishing wizard](https://flakehub.com/new) to verify the repository name, public visibility, and trusted GitHub organization binding.
- Audit all pinned actions, including the nested actions in the shared monorepo composites. The publishing composite derives the package name from `github.repository` and publishes a public rolling release.
- Protect `main`, run `nix flake check --all-systems --no-build` and `nix build`, then rename the disabled file to `flakehub-publish-rolling.yml` if publication is wanted.
- The workflow publishes only pushes to `main` and uses job-scoped OIDC permissions. Delete it if FlakeHub publication is not needed.
- Registry publication and FlakeHub publication are independent. Enabling one does not require enabling the other.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
