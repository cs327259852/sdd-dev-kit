# SDD Dev Kit

[![CI](https://github.com/cs327259852/sdd-dev-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/cs327259852/sdd-dev-kit/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit is a lightweight, portable governance kit for AI-assisted software development.
It keeps coding agents from jumping straight into code by forcing every meaningful change through human-reviewed artifacts:

```text
sdd-bootstrap
sdd-use
sdd-spec
sdd-plan
sdd-tasks
sdd-apply
sdd-validate
sdd-archive
```

It is designed for teams that want spec-driven development without adopting a heavy platform first: copy the workflow, gates, templates, and agent instructions, then let each target project generate its own facts through `sdd-bootstrap`.

## 30-Second Start

Use npm:

```bash
npx sdd-dev-kit init --agent codex
npx sdd-dev-kit check
```

If the npm package is not available yet, use the repository installer below.

Or use the repository directly:

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

Then ask your AI coding agent:

```text
sdd-bootstrap
```

## Why SDD Dev Kit

- **Portable by default**: plain Markdown rules and templates, no service dependency.
- **Project facts stay local**: each project owns its `constitution`, `architecture`, `domain-map`, `glossary`, `modules`, and `features`.
- **Human gates are explicit**: no code changes before Confirmed `spec.md`, Reviewed `plan.md`, and Approved `tasks.md`.
- **Rollback is part of the workflow**: reopen `tasks`, `plan`, or `spec` when implementation reveals a bad assumption.
- **Agent-friendly**: supports Codex, Claude Code, Gemini CLI, GitHub Copilot, Cursor, and Windsurf adapters.

## Demo

See [docs/demo/walkthrough.md](docs/demo/walkthrough.md) for a small end-to-end adoption walkthrough.

## Relationship To Spec Kit

Spec Kit is a broader, ecosystem-oriented spec-driven development harness. SDD Dev Kit is intentionally smaller: it focuses on migrating existing business projects into a Markdown-first governance workflow with project fact sources, rollback rules, and agent routing files. Use Spec Kit when you want a complete extensible toolchain; use SDD Dev Kit when you want a lightweight process package that can be copied into an existing repository quickly.

## What This Project Contains

```text
template/
  AGENTS.md
  docs/sdd/
    AGENTS.md
    workflow.md
    commands/
    templates/
    migration/

adapters/
  claude/
  codex/
    skills/
  copilot/
  cursor/
  gemini/
  windsurf/

scripts/
  install.sh
  check-sdd.sh
```

`template/` contains tool-neutral SDD rules and document templates.
`adapters/` contains agent-specific routing files for Codex, Claude Code, Gemini CLI, GitHub Copilot, Cursor, and Windsurf.
The command rules in `template/docs/sdd/commands/` are the source of truth.

## Quick Start

From a target project:

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

If the target project uses Codex and you want short command triggers:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

Equivalent npm command:

```bash
npx sdd-dev-kit init --codex
```

Install another agent adapter:

```bash
npx sdd-dev-kit init --agent claude
npx sdd-dev-kit init --agent gemini
npx sdd-dev-kit init --agent copilot
```

Install all supported adapters:

```bash
npx sdd-dev-kit init --all-agents
```

See [docs/adapters.md](docs/adapters.md) for adapter details and installed paths.

Then ask your AI coding agent:

```text
sdd-bootstrap
```

The agent should analyze the target project and generate:

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

Review those files before starting feature development.

## Daily Workflow

```text
sdd-use user-export
sdd-spec
human: mark spec.md as Confirmed
sdd-plan
human: mark plan.md as Reviewed
sdd-tasks
human: mark tasks.md as Approved
sdd-apply
sdd-validate
sdd-archive
```

## Closing spec.md Open Questions

Before marking `spec.md` as `Confirmed`, every item in `Open Questions` must be closed with an answer:

```md
- [x] Q: {question}
  A: {confirmed answer or decision}
```

Only after all Open Questions are checked and answered should a human update:

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

The hard gates are intentional:

- No Confirmed `spec.md`, no implementation plan.
- No Reviewed `plan.md`, no task breakdown.
- No Approved `tasks.md`, no code changes.
- Failed validation blocks archive.

## Stage Rollback

Use rollback when a reviewed upstream artifact is no longer correct.

```text
sdd-tasks rollback
{why tasks.md must change}

sdd-plan rollback
{why plan.md must change}

sdd-spec rollback
{why spec.md must change}
```

Rollback rules:

- If tasks are missing or validation is incomplete, roll back `tasks.md`; it must be approved again before code changes continue.
- If the design, impact scope, or validation strategy is wrong, roll back `plan.md`; `tasks.md` is also reopened.
- If requirements, acceptance criteria, business rules, permissions, data meaning, or compatibility changed, roll back `spec.md`; `plan.md` and `tasks.md` are also reopened.
- After rollback, stop coding until the reopened artifacts pass the human gates again.

## Updating an Existing Project

If a project has already installed SDD Dev Kit and this GitHub repository receives updates, update only the portable workflow files:

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

If the target project uses Codex:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

Then verify the integration:

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

Equivalent npm command:

```bash
npx sdd-dev-kit check
```

Do not overwrite project facts during an update. Keep and review the target project's own `constitution.md`, `architecture.md`, `domain-map.md`, `glossary.md`, `modules/*`, and `features/*`.

## What Not To Copy From Another Project

Do not copy project-specific SDD facts from another repository:

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

These files must be generated or reviewed for each target project.

## Verification

Run this from a target project after installation:

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

The checker validates that the portable workflow files exist and that no
project-specific facts were installed accidentally.

## Contributing

Contributions are welcome. Good first areas include new agent adapters, Windows support, npm CLI improvements, demo projects, GitHub Actions checks, and documentation translations. See [CONTRIBUTING.md](CONTRIBUTING.md).
