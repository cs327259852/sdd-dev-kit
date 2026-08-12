# Demo Walkthrough

This walkthrough shows the expected adoption flow in a small existing project.

## 1. Install SDD Dev Kit

From the target project:

```bash
npx sdd-dev-kit init --codex
```

For other agents:

```bash
npx sdd-dev-kit init --agent claude
npx sdd-dev-kit init --agent gemini
npx sdd-dev-kit init --agent copilot
npx sdd-dev-kit init --all-agents
```

Expected result:

```text
AGENTS.md
docs/sdd/AGENTS.md
docs/sdd/workflow.md
docs/sdd/commands/
docs/sdd/templates/
docs/sdd/migration/
docs/sdd/features/.gitkeep
docs/sdd/modules/.gitkeep
.codex/skills/sdd-*.md
```

Project fact files are not installed yet. They must be generated from the target project itself.

## 2. Bootstrap Project Facts

Ask your AI coding agent:

```text
sdd-bootstrap
```

The agent should inspect the target project's README, build files, code structure, configuration examples, interfaces, data access layer, database scripts, and tests.

It should generate:

```text
AGENTS.md
docs/sdd/constitution.md
docs/sdd/architecture.md
docs/sdd/domain-map.md
docs/sdd/glossary.md
docs/sdd/modules/{module}/current.md
docs/sdd/modules/{module}/validate.md
docs/sdd/modules/{module}/history.md
```

Anything the agent cannot prove from code or docs must go into Open Questions.

## 3. Start A Feature

```text
sdd-use add-health-endpoint
sdd-spec
```

Review `spec.md`. Close every Open Question:

```md
- [x] Q: Should the endpoint require authentication?
  A: No. This endpoint is for platform health checks and returns no sensitive data.
```

Then a human marks the spec as confirmed:

```md
- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

## 4. Plan, Task, Implement

```text
sdd-plan
```

Human review:

```md
- Status: Reviewed
- Reviewed By: {name}
- Reviewed At: {yyyy-mm-dd}
```

Then:

```text
sdd-tasks
```

Human approval:

```md
- Status: Approved
- Approved By: {name}
- Approved At: {yyyy-mm-dd}
```

Only now should the agent implement:

```text
sdd-apply
sdd-validate
sdd-archive
```

## 5. Roll Back When Needed

If the implementation reveals a bad assumption, stop coding and reopen the right artifact:

```text
sdd-tasks rollback
sdd-plan rollback
sdd-spec rollback
```

After rollback, the reopened artifacts must pass human gates again before implementation continues.

## 6. Verify Installation

```bash
npx sdd-dev-kit check
```

The checker validates that the portable SDD workflow files exist and warns when project fact files are present and should be reviewed.
