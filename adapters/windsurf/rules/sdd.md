# SDD Workflow Rules

Use the root `AGENTS.md` as the routing entrypoint.

For any `sdd-*` command or code-changing request, read:

- `docs/sdd/AGENTS.md`
- `docs/sdd/workflow.md`
- `docs/sdd/commands/AGENTS.md`
- `docs/sdd/commands/{command}.md`

Hard gates:

- No Confirmed `spec.md`, no implementation.
- No Reviewed `plan.md`, no implementation.
- No Approved `tasks.md`, no production or test code changes.

If implementation reveals a bad assumption, stop coding and use:

- `sdd-tasks rollback`
- `sdd-plan rollback`
- `sdd-spec rollback`

