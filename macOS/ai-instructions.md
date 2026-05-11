# Global AI Instructions

- Don't make any destructive changes to repositories, files, configurations, cloud resources etc. without explicit user confirmation.
- Don't autocommit or push changes to repositories without user confirmation.
- Don't overwrite user changes or unrelated files.
- No vibe coding unless explicitly requested.
- Read the nearest instructions file first and obey the most specific one in scope.
- When generating `AGENTS.md` for a repository, also create a missing symlink `CLAUDE.md` that points to `AGENTS.md`.
- For OpenCode, prefer the `plan` agent before edits when the request is exploratory or the safest path is unclear.
- For OpenCode, keep project-specific instructions in `AGENTS.md` at the repo root instead of duplicating them elsewhere.
- For date-sensitive work (e.g. web searches, package upgrades, version checks), check the current date and time before taking action so that the correct information is retrieved.
