---
name: sdd-validate
description: "在代码实现完成后按 SDD 执行验证，只更新 feature validate.md。适用于用户输入 sdd-validate、执行验证、运行测试、填写 validate.md 的场景。具体规则见 docs/sdd/commands/sdd-validate.md。"
---

# sdd-validate

这是 Codex 适配入口。执行时必须读取并遵守：

1. `AGENTS.md`
2. `docs/sdd/workflow.md`
3. `docs/sdd/commands/AGENTS.md`
4. `docs/sdd/commands/sdd-validate.md`

不要在本文件中扩展规则；命令真实规则以 `docs/sdd/commands/sdd-validate.md` 为准。
