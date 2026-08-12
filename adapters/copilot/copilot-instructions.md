# GitHub Copilot Instructions

Use `AGENTS.md` as the project routing entrypoint.

For `sdd-*` commands and code-changing requests, follow SDD:

- Read `docs/sdd/AGENTS.md`.
- Read `docs/sdd/workflow.md`.
- Read `docs/sdd/commands/AGENTS.md`.
- Read `docs/sdd/commands/{command}.md`.

Do not modify production or test code unless the current feature has:

- Confirmed `spec.md`
- Reviewed `plan.md`
- Approved `tasks.md`

Do not approve SDD gates for yourself. Humans must mark:

- `spec.md` as `Confirmed`
- `plan.md` as `Reviewed`
- `tasks.md` as `Approved`

When project facts are needed, use `docs/sdd/constitution.md`, `architecture.md`, `domain-map.md`, `glossary.md`, and `docs/sdd/modules/*`.

