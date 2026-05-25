---
name: agent-skill-creator
description: Create new agent skills from scratch, improve or optimize existing skills, and measure skill performance with evaluations. Use when the user wants to create a skill, edit or improve an existing skill, run evals or benchmarks to test skill quality, optimize a skill's description for better triggering, or package a skill for distribution. Works across Claude Code, OpenAI Codex, GitHub Copilot, OpenCode, Gemini, and other agents supporting the Agent Skills open standard.
compatibility: Eval scripts require Python 3.10+. init_skill.py and generate_openai_yaml.py require pyyaml. Description optimization scripts (run_loop.py, run_eval.py, improve_description.py) require the Claude Code CLI and only work when running inside Claude Code.
---

# Agent Skill Creator

A skill for creating new agent skills and iteratively improving them. Works across any agent that supports the Agent Skills open standard.

## About Skills

Skills are modular, self-contained directories that extend an agent's capabilities with specialized knowledge, workflows, and tools. They provide:

- **Specialized workflows** — multi-step procedures for specific domains
- **Tool integrations** — instructions for specific file formats, APIs, or CLIs
- **Domain expertise** — project-specific conventions, schemas, business logic
- **Bundled resources** — scripts, references, and assets for complex or repetitive tasks

### Anatomy of a Skill

```
skill-name/
├── SKILL.md          # Required: frontmatter + instructions
├── agents/           # Optional: product-specific metadata
│   └── openai.yaml   # UI metadata for OpenAI-compatible products
├── scripts/          # Optional: executable code
├── references/       # Optional: docs loaded into context on demand
└── assets/           # Optional: templates and files used in output
```

### Progressive Disclosure

Skills load in three stages — structure your content accordingly:

1. **Metadata** (`name` + `description`, ~100 tokens) — always in context; determines if the skill activates
2. **SKILL.md body** (<500 lines recommended) — loaded when the skill activates
3. **Bundled resources** (unlimited) — loaded on demand; scripts can run without being read into context

Keep SKILL.md under 500 lines. Move detailed reference material to `references/`. Tell the agent *when* to read each file — "read `references/api-errors.md` if the API returns non-200" is more useful than a generic pointer.

## Core Principles

**Concise is key.** The context window is shared with everything else: history, other skills, the user request. Only add what the agent wouldn't know without the skill. Challenge each paragraph: does this justify its token cost?

**Match specificity to fragility.** High freedom (text instructions) for decisions that depend on context. Low freedom (exact scripts, exact command flags) for operations that are fragile or must be consistent.

**Explain the why.** Today's agents are smart. When you explain the reasoning behind an instruction, they handle edge cases better than when you issue rigid rules. Avoid all-caps ALWAYS/NEVER; reframe as reasoning instead.

**Include gotchas.** The highest-value content in many skills is a short list of non-obvious facts — environment-specific behaviors, renamed fields, soft-delete patterns — that the agent will get wrong without being told.

## Skill Creation Process

### Step 1: Understand the skill with concrete examples

Skip only if the usage patterns are already clearly understood.

Ask the user:
- What should this skill enable the agent to do?
- When should it trigger? What would the user actually type?
- What's the expected output format?
- Should we set up test cases to verify it works? (Skills with objectively verifiable outputs benefit from test cases; skills with subjective outputs often don't.)

Avoid asking too many questions at once. Start with the most important and follow up.

### Step 2: Plan reusable skill contents

For each concrete example, analyze:
1. How would you execute this from scratch?
2. What scripts, references, or assets would make this repeatable?

Common signals:
- Agent rewrites the same helper code each run → bundle it in `scripts/`
- Same schema or API docs needed every time → put in `references/`
- Same boilerplate output or template → put in `assets/`

### Step 3: Initialize the skill

Ask where the user wants the skill placed. If unspecified, default to the agent's global skills directory (e.g. `~/.codex/skills`, `~/.claude/skills`, `~/.agents/skills`).

Use `scripts/init_skill.py` to scaffold the directory:

```bash
python scripts/init_skill.py <skill-name> --path <output-directory> [--resources scripts,references,assets] [--examples]
```

This creates the directory, a `SKILL.md` template with TODO placeholders, and `agents/openai.yaml`. Skip if the skill already exists.

To regenerate or update `agents/openai.yaml` UI metadata:

```bash
python scripts/generate_openai_yaml.py <path/to/skill-folder> --interface display_name="My Skill" short_description="What it does"
```

Read `references/openai_yaml.md` for field descriptions and constraints before generating values.

### Step 4: Write the skill

#### Frontmatter

- `name`: lowercase hyphen-case, max 64 chars, must match the directory name exactly
- `description`: the primary triggering mechanism — include **what** it does AND **when** to use it; all "when to use" context goes here, not in the body (the body only loads after triggering); max 1024 chars
- `license`: optional — name of license (e.g. `MIT`)
- `compatibility`: optional — only include if the skill requires a specific environment, tool, or agent

Good description pattern: front-load key use cases and trigger words. Lean toward over-triggering rather than under-triggering.

#### Body

Write in imperative form. Structure around the workflow that matches the skill's nature:

- **Workflow-based** (sequential steps) — good for multi-stage processes
- **Task-based** (operation catalogue) — good for skills with multiple independent operations
- **Reference/guidelines** — good for standards and conventions

Patterns can be mixed. Use gotchas sections, output templates, checklists, and validation loops where they add value.

Start with bundled resources (write and test scripts, populate references) before writing the SKILL.md body — instructions should reference concrete tools, not abstract advice.

**Do not create** README.md, CHANGELOG.md, INSTALLATION_GUIDE.md, or other auxiliary documentation. Skills contain only what the agent needs to do the job.

#### Validate

```bash
python scripts/quick_validate.py <path/to/skill-folder>
```

Checks frontmatter format, required fields, name constraints, and description length. Fix reported issues and re-run.

### Step 5: Test on realistic tasks

Run the skill on 2–3 realistic prompts — the kind a real user would actually type. Share the test cases with the user before running: "Here are a few test cases I'd like to try. Do these look right?"

For a structured approach with subagents, baselines, grading, and benchmarking, continue to the **Evaluating** section below.

If subagents are not available, run test cases one at a time using the skill yourself (you wrote it, so you have full context — this is less rigorous but useful as a sanity check). Skip baseline runs.

### Step 6: Iterate

Read execution traces — not just final outputs. If the agent wastes time on unproductive steps, the skill instructions may be too vague or presenting too many equal options.

**Forward-testing with subagents:** pass the skill path and a realistic user request to a fresh subagent. Frame it as a real task, not a test: `Use $skill-name at /path/to/skill to solve <problem>`. Pass raw artifacts, not your diagnosis. Avoid showing expected answers.

Keep going until the user is satisfied, feedback is empty, or you stop making meaningful progress.

## Evaluating Test Cases (structured loop)

Use this when the skill is complex enough to warrant systematic evaluation. This is one continuous sequence — don't stop partway through.

Put results in `<skill-name>-workspace/` as a sibling to the skill directory, organized by iteration (`iteration-1/`, `iteration-2/`, ...) and test case. See `references/schemas.md` for all JSON schemas.

### Spawn all runs in the same turn

For each test case, spawn two subagents simultaneously — one with the skill, one without (or old version when improving an existing skill). Always launch both at once.

**With-skill run:**
```
Execute this task:
- Skill path: <path-to-skill>
- Task: <eval prompt>
- Input files: <eval files or "none">
- Save outputs to: <workspace>/iteration-N/eval-<ID>/with_skill/outputs/
```

**Baseline run** (same prompt, no skill or old skill snapshot):
```
Save outputs to: <workspace>/iteration-N/eval-<ID>/without_skill/outputs/
```

Write an `eval_metadata.json` for each test case with assertions (can be empty initially).

### While runs are in progress, draft assertions

Good assertions are objectively verifiable and have descriptive names. Draft them while subagents run — don't wait. Update `eval_metadata.json` and `evals/evals.json`.

Capture `total_tokens` and `duration_ms` from each subagent notification into `timing.json` immediately — this is the only opportunity.

### Grade, aggregate, and review

1. **Grade each run** — spawn a grader subagent using `agents/grader.md`; save `grading.json` per run
2. **Aggregate:**
   ```bash
   python -m scripts.aggregate_benchmark <workspace>/iteration-N --skill-name <name>
   ```
3. **Analyze patterns** — read `agents/analyzer.md` for what to look for
4. **Share results with the user** — present the benchmark summary and ask for feedback on specific test cases.

### Read feedback and improve

Ask the user for feedback on specific test cases. No feedback on a case means it looked fine. Focus improvements on cases with specific complaints.

## Improving the Skill

1. **Generalize from feedback** — the skill will run on many prompts. Avoid overfitting to test cases.
2. **Keep it lean** — remove instructions that aren't pulling their weight.
3. **Explain the why** — reframe rigid rules as reasoning so the agent handles edge cases well.
4. **Bundle repeated work** — if all test cases had the agent independently write the same helper code, bundle it in `scripts/`.

After improving: rerun into `iteration-<N+1>/`, share results with the user, wait for feedback, repeat.

## Description Optimization

> **Claude Code only.** The scripts below call `claude -p` and depend on Claude Code's CLI, skill registration, and stream output format. Skip this section on other agents.

After the skill is in good shape, optimize its `description` field for triggering accuracy.

**Step 1: Generate 20 trigger eval queries** — ~half should-trigger, ~half should-not-trigger. Focus on near-misses for negatives (adjacent domains, ambiguous phrasing). Save as JSON: `[{"query": "...", "should_trigger": true}, ...]`

**Step 2: Review with user** — share the generated queries and ask the user to confirm or adjust which should/shouldn't trigger before running.

**Step 3: Run the optimization loop:**
```bash
python -m scripts.run_loop \
  --eval-set <path-to-trigger-eval.json> \
  --skill-path <path-to-skill> \
  --model <model-id-powering-this-session> \
  --max-iterations 5 --verbose
```

Use the current session's model ID so triggering tests match what the user actually experiences.

**Step 4: Apply** — take `best_description` from JSON output, update SKILL.md frontmatter, show before/after.


## Packaging

```bash
python -m scripts.package_skill <path/to/skill-folder>
```

Produces a `.skill` file. Present to user with `present_files` tool if available.

When updating an existing skill:
- Preserve the original `name` field and directory name — do not append `-v2`
- If the installed path is read-only, copy to `/tmp/<skill-name>/`, edit there, package from the copy

## Reference Files

| File | When to read |
|---|---|
| `references/schemas.md` | When generating `evals.json`, `grading.json`, `benchmark.json`, or `timing.json` |
| `references/openai_yaml.md` | When creating or regenerating `agents/openai.yaml` |
| `agents/grader.md` | When spawning a grader subagent |
| `agents/analyzer.md` | When analyzing benchmark results |
