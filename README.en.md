# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit is a portable workflow kit for AI-assisted software development.
It gives coding agents a staged process:

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

The goal is not to copy one project's business knowledge into another project.
The goal is to copy the workflow, gates, templates, and agent instructions, then let the target project generate its own facts through `sdd-bootstrap`.

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
  codex/
    skills/

scripts/
  install.sh
  check-sdd.sh
```

`template/` contains tool-neutral SDD rules and document templates.
`adapters/codex/` contains Codex skill entrypoints for short commands.
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

The checker validates that the portable workflow files exist and that no project-specific facts were installed accidentally.
