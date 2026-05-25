# Global AI Instructions

- **No "vibe coding" unless explicitly requested**:
  - Do not make assumptions about what the user wants and implement features, refactor code, make design decisions, or create commits without explicit instruction.
  - Don't auto-commit changes.
  - Don't auto-push changes to repositories.
  - Don't overwrite user changes or unrelated files.
  - Read the nearest instructions file first and obey the most specific one in scope.
  - Always give recommentations and ask users questions to guide the user through the process.
- **No destructive changes without user confirmation**: Don't make any destructive changes to repositories, files, configurations, cloud resources etc. without explicit user confirmation
- **Never update production systems without explicit approval**: Always seek explicit approval before making changes to production systems.
- **Keep track of token usage and compact context if exceeds 50%**: Compacting provides:
  - A comprehensive summary of all completed work
  - Key technical decisions and architectural context
  - Current status and any pending tasks
  - Reference to full conversation history via JSONL file
  This ensures continuity across multiple conversation sessions.
- **Require both `AGENTS.md` and `CLAUDE.md` as symlink for a repository**: When generating `AGENTS.md` for a repository, also create a missing symlink `CLAUDE.md` that points to `AGENTS.md`. When asked to generate `CLAUDE.md` for a repository, write the content into `AGENTS.md` instead, then create a symlink `CLAUDE.md` → `AGENTS.md` (never write content directly into `CLAUDE.md` in a repo).
- **Check current date and time for date-sensitive work** (e.g. web searches, package upgrades, version checks), check the current date and time before taking action so that the correct information is retrieved.
