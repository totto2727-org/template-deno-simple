# Deno Simple Template

A GitHub repository template for starting a small TypeScript command-line application with Deno.

## Usage

Print the starter application's greeting:

```console
$ deno task start
Hello, world!
```

The task runner may print its command before the application output.

## Key features

- Small TypeScript greeting example with no runtime dependencies.
- Ready-to-copy project with automated checks and tests.
- No credentials or runtime permissions required by the sample.

## Prerequisites

- **GitHub**: An account to create a repository from this template.
- **Nix with flakes enabled**: Provides the pinned Deno runtime through the development environment.

## Setup

Create a repository using [Use this template](https://github.com/totto2727-org/template-deno-simple/generate).

## API

### Starter command

`deno task start` writes `Hello, world!` followed by a newline to standard output and exits successfully.
The sample defines no options, ignores extra arguments, and performs no network or file operations.

### `greet(name = "world")`

Returns a greeting for the supplied string without trimming or normalizing it.

```ts
import { greet } from './src/greet.ts'

greet('TypeScript') // "Hello, TypeScript!"
```

## Development

See [AGENTS.md](./AGENTS.md) for development commands and copied-project initialization.

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
