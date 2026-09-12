# template-deno-simple initialization

## Template files

| File                                                      | Meaning                                                                           |
| --------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `README.md`                                               | Template entry point: asks an AI agent to follow this initialization guide.       |
| `AGENTS.md`                                               | Template file map and initialization instructions. Replaced after initialization. |
| `README_TEMPLATE.md`                                      | End-user README skeleton to customize and promote to README.md.                   |
| `AGENTS_TEMPLATE.md`                                      | Copied-project development guidance to customize and promote to AGENTS.md.        |
| `src/`                                                    | Starter source and tests to replace with the new project.                         |
| `deno.json`                                               | Project/package identity, exports, tasks, formatting, and publication patterns.   |
| `flake.nix`                                               | Nix development environment, package outputs, and reusable overlay.               |
| `flake.lock`                                              | Pinned Nix inputs.                                                                |
| `package.nix`                                             | Nix CLI package definition and runtime permissions/dependencies.                  |
| `.envrc`                                                  | Optional direnv entry point for the Nix shell.                                    |
| `.github/workflows/ci.yml`                                | Pre-merge source and registry package validation. Does not build the Nix package. |
| `.github/workflows/publish.yml.disabled`                  | Disabled JSR repository-linked OIDC publication workflow.                         |
| `.github/workflows/flakehub-publish-rolling.yml.disabled` | Disabled public rolling FlakeHub publication workflow.                            |
| `.gitignore`                                              | Local outputs and temporary files excluded from Git.                              |
| `LICENSE`                                                 | License and copyright holder to review for the new project.                       |

## Initialization

### 1. Establish the project

Use the requested repository name, package name, purpose, license, and publication targets.
Resolve missing project-specific decisions with the user rather than inventing registry ownership or publishing credentials.
Work from the copied repository root.

Use `nix develop` to obtain Deno from the pinned environment. The shell also supplies Node.js and Vite+ because the shared publish-jsr action invokes `vpx jsr publish`. CI loads the same environment with `eval "$(nix print-dev-env "$GITHUB_WORKSPACE#default")"` and runs `deno task ci`.
If using direnv, review `.envrc` before explicitly running `direnv allow`.

### 2. Replace metadata and starter files

Replace `@username/project`, version, license, exports, and publication patterns in `deno.json`. Keep the source publication pattern directory-based (`src/`), not a list of individual source files.
Replace `project` in `package.nix`, the package/overlay attributes in `flake.nix`, command names, and documentation with the intended command name.
Update the flake description, repository references, and license holder.
Replace the starter source and tests with the actual project.

Keep the existing formatting defaults: no semicolons, single quotes, line width 120, and unwrapped Markdown prose.
Keep shared `totto2727-org/monorepo` action references on `@main`, matching the other simple templates.
Do not create `CLAUDE.md`.

Retain Nix package/overlay outputs for a distributable CLI. If they are removed, remove their corresponding README installation paths as well.
If runtime dependencies are added, update `package.nix` to bundle or vendor them reproducibly rather than downloading them at runtime.

### 3. Create the project's documentation

Customize `README_TEMPLATE.md` for the actual user-facing features, usage, prerequisites, and supported installation methods. Replace its JSR API reference URL with the actual package URL; do not duplicate the registry-generated API documentation.
Customize `AGENTS_TEMPLATE.md` for the actual file layout, development commands, boundaries, and project-specific rules.
Remove placeholder guidance and unsupported setup methods.
Keep template initialization instructions out of the copied project's final documents.

Determine the required runtime permissions and write concrete, minimally scoped permission flags directly into the README run and global-install commands, keeping Usage and the Nix launcher consistent. Keep the rationale and permission-design instructions in AGENTS, not in the user README. Omit unnecessary permissions and leave no permission placeholders in the generated commands.

Replace these template-only entry documents with the customized project documents:

```bash
rm README.md AGENTS.md
mv README_TEMPLATE.md README.md
mv AGENTS_TEMPLATE.md AGENTS.md
```

### 4. Configure optional publication

Configure or delete each disabled workflow using the instructions below before replacing this guide.
Registry and FlakeHub publication are independent choices.
Do not publish or enable a workflow until the required registry/repository links are configured.

### 5. Validate and hand off

Run `deno task ci` after committing the initialized files, because its publish dry run requires a clean tree. During local edits, run `deno task check`, `deno task test`, and `deno publish --dry-run --allow-dirty` instead. Never add `--allow-dirty` to the publishing workflow.
Nix package builds are not part of normal CI or required initialization validation.
Update dependency lockfiles when dependencies change and `flake.lock` when Nix inputs change.
Review the final documents for remaining placeholders, obsolete template file references, and valid links, then commit the initialized project.

## Publication setup

### JSR repository-linked publishing

1. Replace `@username/project`, the version, exports, and publication include list in `deno.json` with the copied project's metadata.
2. Create the scope and package on JSR under an account you control. In the package's settings, link the exact GitHub owner/repository and require GitHub Actions publication where appropriate.
3. Use the GitHub-hosted runner and job-scoped `id-token: write` in `publish.yml`. JSR obtains OIDC authentication from the linked repository automatically. Do not add a JSR token or a `--token` argument.
4. Audit the third-party action pins and shared monorepo branch references, configure protected release tags, and rename `.github/workflows/publish.yml.disabled` to `publish.yml`.
5. Run `deno task check`, `deno task test`, and `deno publish --dry-run` and review the exact uploaded files. During local work only, add `--allow-dirty` to the dry run if needed; never add it to the publishing workflow.
6. Commit the initialized package and push a protected release tag. The workflow invokes `totto2727-org/monorepo/.github/actions/publish-jsr@main` with `working-directory: .`. That action loads the Nix environment and runs `vpx jsr publish`, using repository-linked OIDC with default provenance enabled. Source checks, tests, and the publish dry run belong to pre-merge CI and are not repeated here. JSR uses the version in `deno.json` and succeeds when that version is already published.

Reference: [JSR GitHub Actions publishing](https://jsr.io/docs/publishing-packages#publishing-from-github-actions).

### FlakeHub rolling publication

- Keep `.github/workflows/flakehub-publish-rolling.yml.disabled` disabled until a copied project explicitly enables publication.
- Use the [official FlakeHub publishing wizard](https://flakehub.com/new) to verify the repository name, public visibility, and trusted GitHub organization binding.
- Keep shared `totto2727-org/monorepo` action references on `@main`, matching the other templates. Review their current implementation and the pinned third-party actions before enabling publication. The publishing composite derives the package name from `github.repository` and publishes a public rolling release.
- Protect `main`, then rename the disabled file to `flakehub-publish-rolling.yml` if publication is wanted.
- The workflow publishes only pushes to `main` and uses job-scoped OIDC permissions. Delete it if FlakeHub publication is not needed.
- Registry publication and FlakeHub publication are independent. Enabling one does not require enabling the other.
