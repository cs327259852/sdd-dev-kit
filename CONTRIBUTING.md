# Contributing

Thanks for improving SDD Dev Kit.

## Good First Contributions

- Add or improve an agent adapter.
- Improve Windows and PowerShell support.
- Improve the npm CLI.
- Add demo target projects.
- Add GitHub Actions checks for SDD gates.
- Improve translations.
- Improve templates for frontend, backend, data, or platform projects.

## Development

Run local checks:

```bash
bash -n scripts/install.sh
bash -n scripts/check-sdd.sh
node bin/sdd-dev-kit.js --help
```

Test installation into a temporary project:

```bash
rm -rf /tmp/sdd-dev-kit-test
mkdir -p /tmp/sdd-dev-kit-test
node bin/sdd-dev-kit.js init --all-agents --target /tmp/sdd-dev-kit-test
node bin/sdd-dev-kit.js check --target /tmp/sdd-dev-kit-test
```

Check npm package contents:

```bash
npm pack --dry-run
```

## Pull Request Guidelines

- Keep workflow rules tool-neutral whenever possible.
- Do not add project-specific business facts to `template/`.
- Do not include credentials, tokens, private keys, database passwords, or production connection strings.
- Update README or demo docs when changing user-facing behavior.
- Add validation notes to the PR description.

## Release Checklist

1. Update `CHANGELOG.md`.
2. Verify CLI and shell installers.
3. Run `npm pack --dry-run`.
4. Tag the release.
5. Publish with npm provenance when available.
