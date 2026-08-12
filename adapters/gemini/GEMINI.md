# GEMINI.md

Use this file at the target project root when using Gemini CLI or Gemini-based coding agents.

The root `AGENTS.md` is the routing entrypoint. The command rules in `docs/sdd/commands/*` are the source of truth for SDD commands.

## SDD Command Routing

For any `sdd-*` command or any request that changes code, behavior, APIs, data semantics, permissions, configuration, storage, or production behavior:

1. Read `AGENTS.md`.
2. Read `docs/sdd/AGENTS.md`.
3. Read `docs/sdd/workflow.md`.
4. Read `docs/sdd/commands/AGENTS.md`.
5. Read `docs/sdd/commands/{command}.md`.

## Hard Gates

- Do not modify code without Confirmed `spec.md`.
- Do not modify code without Reviewed `plan.md`.
- Do not modify code without Approved `tasks.md`.
- Do not mark `spec.md`, `plan.md`, or `tasks.md` as approved for yourself.

## Bootstrap

For first-time adoption in a project, run:

```text
sdd-bootstrap
```

Generate project facts from the target project only. Do not copy facts from another repository.

