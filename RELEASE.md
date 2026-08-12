# Release Guide

This project is published as the npm package `sdd-dev-kit`.

## Current Package Name Check

As of 2026-08-12, `npm view sdd-dev-kit` returned `404 Not Found`, so the package name appeared available at that time.

Recheck before publishing:

```bash
env npm_config_cache=/tmp/npm-cache npm view sdd-dev-kit name version --json
```

`E404` means the package is not currently published.

## Local Publish Prerequisites

1. Create or use an npm account.
2. Login locally:

```bash
env npm_config_cache=/tmp/npm-cache npm login
env npm_config_cache=/tmp/npm-cache npm whoami
```

3. Run release checks:

```bash
npm run check
env npm_config_cache=/tmp/npm-cache npm pack --dry-run
```

4. Publish:

```bash
env npm_config_cache=/tmp/npm-cache npm publish --access public
```

Use `--provenance` when publishing from GitHub Actions with trusted publishing.

## GitHub Actions Trusted Publishing

Recommended long-term path:

1. In npm, configure trusted publishing for this GitHub repository.
2. Confirm package name: `sdd-dev-kit`.
3. Push a version tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

4. The `Publish npm package` workflow will run `npm publish --provenance --access public`.

If trusted publishing is not configured, the workflow will fail at publish time. That is expected and safer than storing long-lived tokens by default.

## Versioning

Before each release:

1. Update `package.json` version.
2. Update `CHANGELOG.md`.
3. Run local validation.
4. Commit the release changes.
5. Create and push a matching tag.
