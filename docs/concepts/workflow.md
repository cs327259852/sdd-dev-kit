# Workflow

Recommended command order:

```text
sdd-bootstrap
sdd-use {feature}
sdd-spec
sdd-plan
sdd-tasks
sdd-apply
sdd-validate
sdd-archive
```

`sdd-bootstrap` is only for first-time adoption in a project.
Feature work starts with `sdd-use`.

Human review gates:

- `spec.md`: `Status: Confirmed`
- `plan.md`: `Status: Reviewed`
- `tasks.md`: `Status: Approved`

The agent may draft these files, but it must not approve them for itself.

