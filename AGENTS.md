# template-deno-simple

## Repository structure

```text
.github/workflows/     Validation and disabled registry/FlakeHub publishing
.envrc                 Optional direnv integration
AGENTS_TEMPLATE.md     Developer guidance for copied projects
README_TEMPLATE.md     End-user documentation for copied projects
deno.json             Package metadata and tasks
flake.nix              Development shell, package, and overlay outputs
flake.lock             Pinned Nix inputs
package.nix            Installable source-based CLI and runtime
src/                   Greeting, CLI entry point, and tests
```

## Development commands

### Execution rules

- Run commands from the repository root.
- Use `nix develop` for the pinned Deno environment. Local development and CI resolve Deno from `flake.lock`, not a separate runtime installer.
- Do not grant blanket -A permissions. The starter application and tests require no extra permissions.
- Use native Deno tasks for source validation and direct Nix commands for package validation.
- Keep semicolons disabled, single quotes enabled, line width 120, and Markdown prose unwrapped.
- Keep `AGENTS.md` as the only canonical agent document. Do not create `CLAUDE.md` in this template family.

### Standard tasks

- `nix develop`: Enter the pinned development shell.
- `nixfmt flake.nix package.nix`: Format the Nix definitions.
- `deno task fix`: Format and apply supported lint fixes.
- `deno task check`: Check formatting, lint, and all discovered TypeScript files.
- `deno task test`: Run all tests.
- `deno task ci`: Run the complete pre-merge validation gate: checks, tests, sample execution, and JSR publish dry run.
- `deno task start`: Run the source CLI.
- `deno task dev`: Watch source changes.
- `deno publish --dry-run`: Validate JSR exports and inspect publication contents without publishing.
- `nix build`: Build the installable command.
- `nix run .`: Run the packaged command.
- `nix flake check --all-systems --no-build`: Evaluate every supported system without cross-compiling.

## Architecture

### Template documentation

- `README.md` and `AGENTS.md` describe this template.
- `README_TEMPLATE.md` and `AGENTS_TEMPLATE.md` become the copied project's canonical documents after initialization.
- Keep all four documents in the same README/AGENTS structure as the other simple templates.

### Command and package

- `src/greet.ts` owns the pure greeting and `src/main.ts` owns standard output.
- `package.nix` uses `writeShellApplication` to install `project` together with Deno and immutable TypeScript sources.
- This source-based Nix package is intentionally dependency-free. When adding runtime dependencies, update it to bundle or vendor them reproducibly rather than resolving packages from the network at runtime.
- `flake.nix` exports `packages.project`, `packages.default`, and `overlays.default` for aarch64-darwin, aarch64-linux, and x86_64-linux.
- JSR exports the greeting module at the package root and the CLI at /cli.
- Normal CI validates only source code and registry package contents. Run Nix package validation manually when changing the packaging. Both workflows load the shell once with `eval "$(nix print-dev-env "$GITHUB_WORKSPACE#default")"` after the shared Nix setup action. Source validation runs `deno task ci`; publication runs `deno publish`.

## Development tools

- **Deno**: Source execution, formatting, linting, type checks, and tests.
- **Nix flakes**: Pinned development tools, installable CLI, and reusable overlay.
- **direnv (optional)**: Loads `.envrc` after the user explicitly runs `direnv allow`.
- **GitHub Actions**: Source/package validation and opt-in OIDC publication.

## Package-specific rules

### Initialize a copied repository

1. Create the repository with GitHub's Use this template flow, clone it, and enter its root.
2. Enter `nix develop`. If using direnv, inspect `.envrc` before running `direnv allow`.
3. Replace `project` in `package.nix`, `flake.nix` package/overlay attributes, the command documentation, and both document templates with the new command name. Replace `username/project`, repository URLs, package names, description, version, and license holder. Retain explicit export paths and include only intended public sources in publish.include.
4. Replace the sample implementation and tests. Keep `package.nix` and package/overlay outputs while distributing a CLI, or remove those outputs and the corresponding README installation paths together.
5. Customize `README_TEMPLATE.md` and `AGENTS_TEMPLATE.md` for the copied project. Remove placeholder guidance and replace the template-only documents:

```bash
rm README.md AGENTS.md
mv README_TEMPLATE.md README.md
mv AGENTS_TEMPLATE.md AGENTS.md
```

6. Configure or delete each disabled publishing workflow using the sections below. Do not create a `CLAUDE.md` alias.
7. Validate the initialized source with `deno task ci`. Nix package validation is independent and is not part of normal CI. Run `nix flake update` when upgrading Nix inputs and commit `flake.lock`; commit deno.lock when external dependencies are introduced.

### JSR repository-linked publishing

1. Replace `@username/project`, the version, exports, and publication include list in `deno.json` with the copied project's metadata.
2. Create the scope and package on JSR under an account you control. In the package's settings, link the exact GitHub owner/repository and require GitHub Actions publication where appropriate.
3. Use the GitHub-hosted runner and job-scoped `id-token: write` in `publish.yml`. JSR obtains OIDC authentication from the linked repository automatically. Do not add a JSR token or a `--token` argument.
4. Audit the third-party action pins and shared monorepo branch references, configure protected release tags, and rename `.github/workflows/publish.yml.disabled` to `publish.yml`.
5. Run `deno task check`, `deno task test`, and `deno publish --dry-run` and review the exact uploaded files. During local work only, add `--allow-dirty` to the dry run if needed; never add it to the publishing workflow.
6. Commit the initialized package and push a protected release tag. The workflow loads the Nix environment and runs only `deno publish` after setup, with default provenance enabled. Source checks, tests, and the publish dry run belong to pre-merge CI and are not repeated here. JSR uses the version in `deno.json` and succeeds when that version is already published.

Reference: [JSR GitHub Actions publishing](https://jsr.io/docs/publishing-packages#publishing-from-github-actions).

### FlakeHub rolling publication

- Keep `.github/workflows/flakehub-publish-rolling.yml.disabled` disabled until a copied project explicitly enables publication.
- Use the [official FlakeHub publishing wizard](https://flakehub.com/new) to verify the repository name, public visibility, and trusted GitHub organization binding.
- Keep shared `totto2727-org/monorepo` action references on `@main`, matching the other templates. Review their current implementation and the pinned third-party actions before enabling publication. The publishing composite derives the package name from `github.repository` and publishes a public rolling release.
- Protect `main`, run `nix flake check --all-systems --no-build` and `nix build`, then rename the disabled file to `flakehub-publish-rolling.yml` if publication is wanted.
- The workflow publishes only pushes to `main` and uses job-scoped OIDC permissions. Delete it if FlakeHub publication is not needed.
- Registry publication and FlakeHub publication are independent. Enabling one does not require enabling the other.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
