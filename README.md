# bootstrap

Bootstrap scripts for development environments on MacBooks and Cloud servers.

## macOS

Run the interactive bootstrap script to set up a new Mac:

```bash
bash macOS/bootstrap.sh
```

Each step prompts before running — press `Y` to run, `n` to skip, or `q` to quit.

## Git hooks (Lefthook)

This repo uses [Lefthook](https://github.com/evilmartians/lefthook) to run checks on staged files before each commit.

### Install

Lefthook is included as a step in `bootstrap.sh`. To install it standalone:

```bash
brew install lefthook
lefthook install
```

### Hooks

Defined in [`lefthook.yml`](lefthook.yml), these run in parallel on `git commit`:

| Hook | Files | What it checks |
|---|---|---|
| `shellcheck` | `*.sh` | Shell script issues (severity: warning+) |
| `shfmt` | `*.sh` | Formatting — 4-space indent, consistent indentation |
| `markdownlint` | `*.md` | Markdown style and structure |

### Common commands

```bash
# Run all pre-commit hooks manually against staged files
lefthook run pre-commit

# Run a single hook by name
lefthook run pre-commit --commands shellcheck

# Skip hooks for a one-off commit
LEFTHOOK=0 git commit -m "message"

# Re-install hooks after pulling changes to lefthook.yml
lefthook install
```
