#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: install.sh [--codex] [--force] [--target DIR]

Copies the portable SDD workflow into a target project.

Options:
  --codex       Also install Codex skill entrypoints into .codex/skills.
  --force       Overwrite existing portable SDD files.
  --target DIR  Target project directory. Defaults to current directory.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$(pwd)"
INSTALL_CODEX=0
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex)
      INSTALL_CODEX=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --target)
      TARGET_DIR="${2:?missing target directory}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

mkdir -p "$TARGET_DIR"

copy_dir() {
  local src="$1"
  local dst="$2"
  if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
    echo "Skip existing: $dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  cp -R "$src" "$dst"
  echo "Installed: $dst"
}

copy_file() {
  local src="$1"
  local dst="$2"
  if [[ -e "$dst" && "$FORCE" -ne 1 ]]; then
    echo "Skip existing: $dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "Installed: $dst"
}

copy_file "$KIT_ROOT/template/AGENTS.md" "$TARGET_DIR/AGENTS.md"
copy_file "$KIT_ROOT/template/docs/sdd/AGENTS.md" "$TARGET_DIR/docs/sdd/AGENTS.md"
copy_file "$KIT_ROOT/template/docs/sdd/workflow.md" "$TARGET_DIR/docs/sdd/workflow.md"
copy_dir "$KIT_ROOT/template/docs/sdd/commands" "$TARGET_DIR/docs/sdd/commands"
copy_dir "$KIT_ROOT/template/docs/sdd/templates" "$TARGET_DIR/docs/sdd/templates"
copy_dir "$KIT_ROOT/template/docs/sdd/migration" "$TARGET_DIR/docs/sdd/migration"

mkdir -p "$TARGET_DIR/docs/sdd/features" "$TARGET_DIR/docs/sdd/modules" "$TARGET_DIR/.sdd"
touch "$TARGET_DIR/docs/sdd/features/.gitkeep" "$TARGET_DIR/docs/sdd/modules/.gitkeep" "$TARGET_DIR/.sdd/.gitkeep"

if [[ "$INSTALL_CODEX" -eq 1 ]]; then
  copy_dir "$KIT_ROOT/adapters/codex/skills" "$TARGET_DIR/.codex/skills"
fi

echo
echo "SDD workflow files installed."
echo "Next: open the target project with your AI coding agent and run: sdd-bootstrap"

