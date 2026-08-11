# sdd-help

向用户说明 SDD 流程怎么操作、有哪些命令、各命令的作用和使用示例；也支持说明某个具体命令。

## Input

```text
sdd-help
```

查看某个具体命令：

```text
sdd-help sdd-plan
```

完整自然语言也支持，例如：

```text
使用 sdd-help 说明 SDD 流程怎么操作
使用 sdd-help 说明 sdd-plan 怎么用
```

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 如果用户未指定具体命令，汇总 SDD 流程阶段、命令列表、命令作用、使用示例和常见下一步。
3. 如果用户指定具体命令，读取对应的 `docs/sdd/commands/{command}.md`，说明该命令的作用、输入、前置条件、使用示例、输出内容和下一步。
4. 不修改任何文件。

如果用户指定的命令不存在，列出支持的 SDD 命令并提示用户重新输入。

## Workflow Summary

推荐流程：

```text
sdd-bootstrap  # 仅新项目首次引入 SDD 时使用
sdd-use {feature-name}
sdd-spec
人工确认 spec.md 为 Confirmed
sdd-plan
人工确认 plan.md 为 Reviewed
sdd-tasks
人工确认 tasks.md 为 Approved
sdd-apply
sdd-validate
sdd-archive
```

## Command Summary

| Command | Purpose | Example | Next |
| --- | --- | --- | --- |
| `sdd-bootstrap` | 在新项目中根据迁移指导构建 SDD 开发范式 | `sdd-bootstrap` | 人工 review 项目级 SDD 文件后 `sdd-use {feature}` |
| `sdd-use` | 选择或创建当前 feature 目录 | `sdd-use user-export` | `sdd-spec` 或 `sdd-status` |
| `sdd-status` | 查看当前 feature 阶段状态 | `sdd-status` | 按阻塞门禁提示 |
| `sdd-spec` | 生成 Draft `spec.md` | `sdd-spec` + 需求描述 | 人工 Confirmed 后 `sdd-plan` |
| `sdd-plan` | 生成 Draft `plan.md` | `sdd-plan` | 人工 Reviewed 后 `sdd-tasks` |
| `sdd-tasks` | 生成 Draft `tasks.md`，按影响范围生成 `api-change.md`、`db-change.md`、`config-change.md`，并声明项目级文档影响 | `sdd-tasks` | 人工 review 交付物并 Approved 后 `sdd-apply` |
| `sdd-apply` | 按 `tasks.md` 修改代码，并按任务更新适用的项目级文档 | `sdd-apply` | `sdd-validate` |
| `sdd-validate` | 执行验证、核对项目级文档一致性并更新 feature `validate.md` | `sdd-validate` | 通过后 `sdd-archive` |
| `sdd-archive` | 验证通过后更新模块 `current.md` 和 `history.md` | `sdd-archive` | 提交、合并或发布 |

## Rollback Commands

| Command | Purpose | Example |
| --- | --- | --- |
| `sdd-spec rollback` | 回退需求规格，同时回退 `plan.md` 和 `tasks.md` | `sdd-spec rollback` + 原因 |
| `sdd-plan rollback` | 回退实现方案，同时回退 `tasks.md` | `sdd-plan rollback` + 原因 |
| `sdd-tasks rollback` | 回退任务拆解 | `sdd-tasks rollback` + 原因 |

## Bootstrap Command

`sdd-bootstrap` 只用于新项目首次引入 SDD 或迁移 SDD 范式。它根据 `docs/sdd/migration/` 中的说明和模板生成项目级 SDD 初稿，包括根 `AGENTS.md`、`constitution.md`、`architecture.md`、`domain-map.md`、`glossary.md` 和模块级事实源。

`sdd-bootstrap` 不用于当前项目普通 feature 开发，不修改业务代码，不生成 feature `spec.md`、`plan.md`、`tasks.md` 或 `validate.md`，也不绕过 `spec -> plan -> tasks -> apply` 门禁。

## Output

回复必须包含：

- 本命令完成了什么：说明 SDD 流程，或说明某个具体命令。
- 修改了哪些文件：必须说明未修改文件。
- 用户未指定具体命令时：
  - SDD 推荐流程顺序。
  - 各命令作用。
  - 常用使用示例。
  - 回退命令的使用场景。
  - 用户下一步通常应该执行什么命令。
- 用户指定具体命令时：
  - 该命令的作用。
  - 该命令的使用示例。
  - 该命令的前置门禁。
  - 该命令会修改哪些文件。
  - 该命令完成后的下一步。
