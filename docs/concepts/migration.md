# Migration

To migrate SDD into another project:

1. Install the portable files with `scripts/install.sh`.
2. Run `sdd-bootstrap` through your AI coding agent.
3. Review the generated project facts.
4. Close all relevant Open Questions.
5. Start feature work with `sdd-use`.

`sdd-bootstrap` must generate project facts from the target project. It must not
copy facts from the source repository that provided this kit.

