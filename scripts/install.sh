#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: install.sh [--codex] [--agent NAME] [--all-agents] [--force] [--target DIR]

Copies the portable SDD workflow into a target project.

Options:
  --agent NAME  Install an agent adapter. Supported: codex, claude, gemini, copilot, cursor, windsurf.
  --all-agents  Install all supported agent adapters.
  --codex       Legacy shortcut for --agent codex.
  --force       Overwrite existing portable workflow files.
  --target DIR  Target project directory. Defaults to current directory.
USAGE
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KIT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$(pwd)"
FORCE=0
ALL_AGENTS=0
AGENTS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --codex)
      AGENTS+=("codex")
      shift
      ;;
    --agent)
      AGENTS+=("${2:?missing agent name}")
      shift 2
      ;;
    --all-agents)
      ALL_AGENTS=1
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

install_agent() {
  local agent="$1"
  case "$agent" in
    codex)
      copy_dir "$KIT_ROOT/adapters/codex/skills" "$TARGET_DIR/.codex/skills"
      ;;
    claude)
      copy_file "$KIT_ROOT/adapters/claude/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
      ;;
    gemini)
      copy_file "$KIT_ROOT/adapters/gemini/GEMINI.md" "$TARGET_DIR/GEMINI.md"
      ;;
    copilot)
      copy_file "$KIT_ROOT/adapters/copilot/copilot-instructions.md" "$TARGET_DIR/.github/copilot-instructions.md"
      ;;
    cursor)
      copy_dir "$KIT_ROOT/adapters/cursor/rules" "$TARGET_DIR/.cursor/rules"
      ;;
    windsurf)
      copy_dir "$KIT_ROOT/adapters/windsurf/rules" "$TARGET_DIR/.windsurf/rules"
      ;;
    *)
      echo "Unsupported agent: $agent" >&2
      echo "Supported agents: codex, claude, gemini, copilot, cursor, windsurf" >&2
      exit 2
      ;;
  esac
}

if [[ "$ALL_AGENTS" -eq 1 ]]; then
  AGENTS=(codex claude gemini copilot cursor windsurf)
fi

for agent in "${AGENTS[@]}"; do
  install_agent "$agent"
done

echo
echo "SDD workflow files installed."
if [[ "${#AGENTS[@]}" -gt 0 ]]; then
  printf "Agent adapters installed: %s\n" "${AGENTS[*]}"
fi
echo "Next: open the target project with your AI coding agent and run: sdd-bootstrap"
