# Python Service Example

For a Python service, `sdd-bootstrap` should inspect:

- `pyproject.toml`, `requirements.txt`, or lock files
- application entrypoints
- routers or command handlers
- service and domain modules
- database models or migrations
- configuration loading
- tests

The generated SDD facts should document runtime, dependency management,
configuration rules, data access boundaries, and validation commands.

