# template-deno-simple

## Repository structure

```text
src/main.ts                 Command-line entry point
src/greet.ts                Pure greeting function
src/greet_test.ts           Greeting contract tests
deno.json                   Deno tasks and formatting settings
.github/workflows/ci.yml    Source validation
```

## Development commands

### Execution rules

- Run commands from the repository root.
- Use Deno 2.9.5. No dependency installation is needed.
- Keep `CLAUDE.md -> AGENTS.md` as a relative symbolic link.
- Keep Markdown sentences on one line.

### Standard tasks

- `deno task check`: Check formatting, lint, and TypeScript types.
- `deno task fix`: Format the repository and apply automatic lint fixes.
- `deno task test`: Run tests without additional permissions.
- `deno task start`: Run the sample.
- `deno task dev`: Run the sample and watch source changes.
- `deno fmt`: Format the repository.

## Architecture

### Sample application

- `greet` owns the pure string transformation and `main.ts` owns standard output.
- Tests exercise the default greeting and supplied names without mocking internal code.
- The template uses only built-in Deno and Node-compatible APIs. Tests need no network, filesystem, environment, or subprocess permissions.

### Automation

- GitHub Actions runs the same checks and tests as local development on pull requests and pushes to main.
- Actions use pinned commit references and read-only repository permissions.
- No publishing or deployment is enabled.

## Development tools

- **Deno**: TypeScript execution, formatting, linting, type checking, and tests.
- **GitHub Actions**: Automated validation.

## Package-specific rules

- After copying, rename the project in documentation, update repository links and the license holder, and replace the greeting with the new application behavior.
- Commit deno.lock when adding external dependencies. Grant only the permissions the new application actually requires, never blanket -A by default.
- Preserve the template documentation structure when replacing its content. No template rendering step is required.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
