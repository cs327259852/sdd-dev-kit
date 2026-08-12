#!/usr/bin/env node
import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const kitRoot = path.resolve(__dirname, "..");

const requiredPaths = [
  "AGENTS.md",
  "docs/sdd/AGENTS.md",
  "docs/sdd/workflow.md",
  "docs/sdd/commands/AGENTS.md",
  "docs/sdd/commands/sdd-bootstrap.md",
  "docs/sdd/commands/sdd-use.md",
  "docs/sdd/commands/sdd-spec.md",
  "docs/sdd/commands/sdd-plan.md",
  "docs/sdd/commands/sdd-tasks.md",
  "docs/sdd/commands/sdd-apply.md",
  "docs/sdd/commands/sdd-validate.md",
  "docs/sdd/commands/sdd-archive.md",
  "docs/sdd/templates/spec-template.md",
  "docs/sdd/templates/plan-template.md",
  "docs/sdd/templates/tasks-template.md",
  "docs/sdd/templates/validate-template.md",
  "docs/sdd/migration/README.md",
  "docs/sdd/migration/project-bootstrap-guide.md"
];

const projectFactPaths = [
  "docs/sdd/constitution.md",
  "docs/sdd/architecture.md",
  "docs/sdd/domain-map.md",
  "docs/sdd/glossary.md"
];

function usage() {
  console.log(`SDD Dev Kit

Usage:
  sdd-dev-kit init [--codex] [--force] [--target DIR]
  sdd-dev-kit check [--target DIR]
  sdd-dev-kit version

Commands:
  init     Copy portable SDD workflow files into a target project.
  check    Validate SDD workflow files in a target project.
  version  Print the package version.

Options:
  --codex       Also install Codex skill entrypoints.
  --force       Overwrite existing portable workflow files.
  --target DIR  Target project directory. Defaults to current directory.
`);
}

function parseOptions(args) {
  const options = {
    codex: false,
    force: false,
    target: process.cwd()
  };

  for (let i = 0; i < args.length; i += 1) {
    const arg = args[i];
    if (arg === "--codex") {
      options.codex = true;
    } else if (arg === "--force") {
      options.force = true;
    } else if (arg === "--target") {
      const value = args[i + 1];
      if (!value) {
        throw new Error("Missing value for --target");
      }
      options.target = path.resolve(value);
      i += 1;
    } else if (arg === "-h" || arg === "--help") {
      options.help = true;
    } else {
      throw new Error(`Unknown option: ${arg}`);
    }
  }

  return options;
}

function ensureDir(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function copyFile(src, dst, force) {
  if (fs.existsSync(dst) && !force) {
    console.log(`Skip existing: ${dst}`);
    return;
  }
  ensureDir(path.dirname(dst));
  fs.copyFileSync(src, dst);
  console.log(`Installed: ${dst}`);
}

function copyDir(src, dst, force) {
  if (fs.existsSync(dst) && !force) {
    console.log(`Skip existing: ${dst}`);
    return;
  }
  fs.rmSync(dst, { recursive: true, force: true });
  fs.cpSync(src, dst, { recursive: true });
  console.log(`Installed: ${dst}`);
}

function touch(file) {
  ensureDir(path.dirname(file));
  if (!fs.existsSync(file)) {
    fs.writeFileSync(file, "");
  }
}

function init(options) {
  const target = path.resolve(options.target);
  ensureDir(target);

  copyFile(path.join(kitRoot, "template/AGENTS.md"), path.join(target, "AGENTS.md"), options.force);
  copyFile(path.join(kitRoot, "template/docs/sdd/AGENTS.md"), path.join(target, "docs/sdd/AGENTS.md"), options.force);
  copyFile(path.join(kitRoot, "template/docs/sdd/workflow.md"), path.join(target, "docs/sdd/workflow.md"), options.force);
  copyDir(path.join(kitRoot, "template/docs/sdd/commands"), path.join(target, "docs/sdd/commands"), options.force);
  copyDir(path.join(kitRoot, "template/docs/sdd/templates"), path.join(target, "docs/sdd/templates"), options.force);
  copyDir(path.join(kitRoot, "template/docs/sdd/migration"), path.join(target, "docs/sdd/migration"), options.force);

  touch(path.join(target, "docs/sdd/features/.gitkeep"));
  touch(path.join(target, "docs/sdd/modules/.gitkeep"));
  touch(path.join(target, ".sdd/.gitkeep"));

  if (options.codex) {
    copyDir(path.join(kitRoot, "adapters/codex/skills"), path.join(target, ".codex/skills"), options.force);
  }

  console.log("");
  console.log("SDD workflow files installed.");
  console.log("Next: open the target project with your AI coding agent and run: sdd-bootstrap");
}

function check(options) {
  const target = path.resolve(options.target);
  let missing = false;

  for (const relativePath of requiredPaths) {
    if (!fs.existsSync(path.join(target, relativePath))) {
      console.log(`Missing: ${relativePath}`);
      missing = true;
    }
  }

  for (const relativePath of projectFactPaths) {
    if (fs.existsSync(path.join(target, relativePath))) {
      console.log(`Notice: project fact exists and should be reviewed: ${relativePath}`);
    }
  }

  const featuresDir = path.join(target, "docs/sdd/features");
  if (fs.existsSync(featuresDir)) {
    const entries = fs.readdirSync(featuresDir).filter((entry) => entry !== ".gitkeep");
    if (entries.length > 0) {
      console.log("Notice: feature files exist under docs/sdd/features; ensure they belong to this project.");
    }
  }

  if (missing) {
    console.log("SDD integration check failed.");
    process.exitCode = 1;
    return;
  }

  console.log("SDD integration check passed.");
}

function version() {
  const packageJson = JSON.parse(fs.readFileSync(path.join(kitRoot, "package.json"), "utf8"));
  console.log(packageJson.version);
}

function main() {
  const [command, ...args] = process.argv.slice(2);

  if (!command || command === "-h" || command === "--help") {
    usage();
    return;
  }

  try {
    if (command === "init") {
      const options = parseOptions(args);
      if (options.help) {
        usage();
        return;
      }
      init(options);
    } else if (command === "check") {
      const options = parseOptions(args);
      if (options.help) {
        usage();
        return;
      }
      check(options);
    } else if (command === "version" || command === "--version" || command === "-v") {
      version();
    } else {
      throw new Error(`Unknown command: ${command}`);
    }
  } catch (error) {
    console.error(error.message);
    console.error("");
    usage();
    process.exitCode = 2;
  }
}

main();

