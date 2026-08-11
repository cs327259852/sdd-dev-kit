---
name: sdd-tasks
description: "在 plan.md 已人工 Reviewed 后生成 Draft tasks.md，并按影响范围生成 api-change.md、db-change.md、config-change.md，或在任务拆解需要调整时回退 tasks.md。适用于用户输入 sdd-tasks、拆任务、生成 tasks、回退 tasks 的场景。具体规则见 docs/sdd/commands/sdd-tasks.md。"
---

# sdd-tasks

这是 Codex 适配入口。执行时必须读取并遵守：

1. `AGENTS.md`
2. `docs/sdd/workflow.md`
3. `docs/sdd/commands/AGENTS.md`
4. `docs/sdd/commands/sdd-tasks.md`

不要在本文件中扩展规则；命令真实规则以 `docs/sdd/commands/sdd-tasks.md` 为准。
