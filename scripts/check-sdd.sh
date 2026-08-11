#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$(pwd)}"
missing=0

required=(
  "AGENTS.md"
  "docs/sdd/AGENTS.md"
  "docs/sdd/workflow.md"
  "docs/sdd/commands/AGENTS.md"
  "docs/sdd/commands/sdd-bootstrap.md"
  "docs/sdd/commands/sdd-use.md"
  "docs/sdd/commands/sdd-spec.md"
  "docs/sdd/commands/sdd-plan.md"
  "docs/sdd/commands/sdd-tasks.md"
  "docs/sdd/commands/sdd-apply.md"
  "docs/sdd/commands/sdd-validate.md"
  "docs/sdd/commands/sdd-archive.md"
  "docs/sdd/templates/spec-template.md"
  "docs/sdd/templates/plan-template.md"
  "docs/sdd/templates/tasks-template.md"
  "docs/sdd/templates/validate-template.md"
  "docs/sdd/migration/README.md"
  "docs/sdd/migration/project-bootstrap-guide.md"
)

for path in "${required[@]}"; do
  if [[ ! -e "$TARGET_DIR/$path" ]]; then
    echo "Missing: $path"
    missing=1
  fi
done

project_specific=(
  "docs/sdd/constitution.md"
  "docs/sdd/architecture.md"
  "docs/sdd/domain-map.md"
  "docs/sdd/glossary.md"
)

for path in "${project_specific[@]}"; do
  if [[ -e "$TARGET_DIR/$path" ]]; then
    echo "Notice: project fact exists and should be reviewed: $path"
  fi
done

if find "$TARGET_DIR/docs/sdd/features" -mindepth 1 ! -name ".gitkeep" -print -quit 2>/dev/null | grep -q .; then
  echo "Notice: feature files exist under docs/sdd/features; ensure they belong to this project."
fi

if [[ "$missing" -ne 0 ]]; then
  echo "SDD integration check failed."
  exit 1
fi

echo "SDD integration check passed."

