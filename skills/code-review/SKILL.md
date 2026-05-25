---
name: code-review
description: Review code changes for correctness, security, clarity, and adherence to project conventions. Use when the user asks to review code, check a diff, or audit a PR.
---

Prioritize bugs, security risks, regressions, and maintainability hazards. Not a style rewrite.

**Check:**

- Failures for valid/empty/boundary inputs, concurrency, partial failures, time zones
- Broken public contracts: APIs, schemas, migrations, CLI flags, env vars
- Security: injection, path traversal, XSS, CSRF, authz gaps, secret exposure, over-broad permissions
- Error handling consistency with surrounding code
- Tests updated at the right level for the risk introduced
- Responsibilities scoped, abstractions justified now (not speculative), dependencies toward stable layers, hidden coupling or shared mutable state

**Severity:**

- **Must fix**: production bug, data loss, security issue, broken contract, deployment blocker
- **Should fix**: plausible edge-case bug, missing test for changed behavior, meaningful maintainability risk
- **Consider**: low-risk improvement, optional clarity or test hardening

**Output:** Findings ordered by severity. Each: severity label · location · what can go wrong · why it matters · concrete fix. Add Open Questions or Test Gaps only if material. Close with a one-sentence summary. Say explicitly if nothing found.
