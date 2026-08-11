# Claude Adapter

Copy this file to the target project's `CLAUDE.md` when using Claude Code.

Claude should treat `docs/sdd/commands/*` as the source of truth for SDD
commands. The root `AGENTS.md` remains the routing entrypoint.

Recommended usage:

```text
sdd-bootstrap
sdd-use user-export
sdd-spec
sdd-plan
sdd-tasks
sdd-apply
sdd-validate
sdd-archive
```

Before executing any `sdd-*` command, read:

1. `AGENTS.md`
2. `docs/sdd/AGENTS.md`
3. `docs/sdd/workflow.md`
4. `docs/sdd/commands/AGENTS.md`
5. `docs/sdd/commands/{command}.md`

