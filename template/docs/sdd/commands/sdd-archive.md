# sdd-archive

验证通过后执行 SDD 收尾，更新模块 `current.md` 和 `history.md`。

## Input

```text
sdd-archive
```

## Preconditions

读取当前 feature 的 `validate.md`，必须满足：

- 无阻塞性 `FAIL`
- 必须执行的验证均为 `PASS`
- `NOT RUN` 项均有明确且可接受的原因
- 不存在需要回退 `spec.md`、`plan.md`、`tasks.md` 或 tasks 阶段交付物的问题

任一不满足，停止，不更新模块文档。

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `spec.md`、`plan.md`、`tasks.md`、`api-change.md`、`db-change.md`、`config-change.md`、`validate.md`（不存在的交付物需确认在 `tasks.md` 中有不适用说明）。
3. 读取 `tasks.md` 的 Project Docs Impact 和 `validate.md` 中的项目级文档一致性验证结论。
4. 如果 Project Docs Impact 标记适用的项目级文档未更新、未验证或与代码 / feature 文档 / 模块文档不一致，停止收尾并报告阻塞原因。
5. 确定受影响模块。
6. 覆盖更新相关模块 `current.md`，使其反映最新真实行为。
7. 追加更新相关模块 `history.md`。
8. 不在 `current.md` 中写流水账。

## Forbidden

- 验证失败时不得执行本阶段。
- 不修改 feature 的需求、方案或任务状态。
- 不静默忽略未执行验证。
- 不在 `sdd-archive` 阶段临时新增或修改 `architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md`；这些项目级文档必须在 `sdd-apply` 阶段按 Approved tasks 修改，并在 `sdd-validate` 阶段验证。

## Output

回复必须包含：

- 本命令完成了什么：完成 SDD 收尾。
- 修改了哪些文件。
- 更新的模块 `current.md`。
- 更新的模块 `history.md`。
- 项目级文档一致性验证结论。
- feature 验证结论。
- 剩余风险或 NOT RUN 项说明。
- 当前 feature 处于什么状态。
- 是否满足下一阶段门禁：通常为已完成。
- 下一步应该执行什么命令或动作：提交、合并或发布。
- 如果不能收尾，说明阻塞原因和需要人工完成的动作。
