---
name: code-complexity
description: Analyse code for complexity issues and suggest reductions. Use when the user asks to check complexity, simplify code, or reduce technical debt.
---

Evaluate the code for complexity using these signals:

**Cyclomatic complexity** — count decision points (if, else, switch cases, loops, catch, ternaries, logical operators). Flag any function with more than ~10 branches; suggest splitting or extracting early returns.

**Cognitive complexity** — focus on nesting depth and logical operator density. Deeply nested blocks are harder to read than equivalent flat code; flatten with guard clauses or extracted functions.

**Coupling** — identify modules that reach into each other's internals, share mutable state, or have implicit execution ordering. High coupling makes isolated changes risky.

**Dead code** — flag unused variables, unreachable branches, obsolete classes or interfaces. Dead code adds noise without value.

**Size** — functions or files that do too much. A function that needs a paragraph to describe what it does is a candidate to split.

For each issue found:
- Name the specific metric or signal
- Show the problematic code span
- Give a concrete refactor suggestion (early return, extracted function, interface boundary, deletion)

Severity guide:
- **Must fix**: cyclomatic complexity > 15, coupling that makes testing impossible, widespread dead code
- **Should fix**: nesting > 3 levels, functions > ~40 lines, high Halstead vocabulary
- **Consider**: moderate coupling, mid-size functions that could be cleaner
