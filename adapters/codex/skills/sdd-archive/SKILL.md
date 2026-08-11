---
name: sdd-archive
description: "在验证通过后执行 SDD 收尾，将 feature 结果沉淀回模块 current.md 和 history.md。适用于用户输入 sdd-archive、归档、收尾、更新模块文档的场景。具体规则见 docs/sdd/commands/sdd-archive.md。"
---

# sdd-archive

这是 Codex 适配入口。执行时必须读取并遵守：

1. `AGENTS.md`
2. `docs/sdd/workflow.md`
3. `docs/sdd/commands/AGENTS.md`
4. `docs/sdd/commands/sdd-archive.md`

不要在本文件中扩展规则；命令真实规则以 `docs/sdd/commands/sdd-archive.md` 为准。
