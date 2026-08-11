# What Is SDD

SDD is a staged development workflow for human and AI collaboration.

It separates a change into explicit artifacts:

- `spec.md`: what problem is being solved and how success is verified.
- `plan.md`: how the implementation will work.
- `tasks.md`: the approved execution checklist.
- `validate.md`: verification evidence.
- module `current.md` and `history.md`: durable project facts after the change.

The workflow is designed to prevent an AI agent from jumping directly from a
request to code changes without reviewed requirements, reviewed design, and
approved tasks.

