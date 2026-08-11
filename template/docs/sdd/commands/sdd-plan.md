# sdd-plan

基于已 Confirmed 的 `spec.md` 生成 Draft `plan.md`，或回退 `plan.md`。

## Input

生成 plan：

```text
sdd-plan
```

回退 plan：

```text
sdd-plan rollback
{回退原因}
```

## Preconditions

读取当前 feature 的 `spec.md`，必须满足：

- `Status: Confirmed`
- `Confirmed By` 非空
- `Confirmed At` 非空
- `Open Questions` 已全部关闭：所有问题必须为 `[x]`，并包含答案 `A`

任一不满足，停止，不生成 `plan.md`。

## Generate Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `spec.md`。
3. 读取相关模块的 `current.md`、`validate.md`、`history.md`。
4. 使用 `docs/sdd/templates/plan-template.md` 生成或更新 `plan.md`。
5. 在 `plan.md` 中补充质量属性方案：最小影响实现策略、可扩展性取舍、异常边界处理、性能 / 容量风险、可维护性 / 可读性和关键中文注释要求。
6. 保持：

```md
- Status: Draft
- Reviewed By:
- Reviewed At:
```

## Rollback Behavior

当用户要求回退 `plan.md` 时：

1. 停止编码或验证。
2. 读取 `plan.md`、`tasks.md` 以及已存在的 `api-change.md`、`db-change.md`、`config-change.md`。
3. 将 `plan.md` 的 `Status` 改为 `Draft`。
4. 清空 `Reviewed By` 和 `Reviewed At`。
5. 在 `plan.md` 的 Reopen History 追加记录。
6. 如果存在 `tasks.md`，将 `tasks.md` 回退为 `Draft`，清空 `Approved By/Approved At`，并记录 `Plan reopened`。
7. 如果存在 `api-change.md`、`db-change.md`、`config-change.md`，提醒这些交付物需在重新执行 `sdd-tasks` 时按新 plan 复核或更新。
8. 根据回退原因修改 `plan.md`。
9. 提醒用户重新 review `plan.md`。

## Forbidden

- 不生成 `tasks.md`、`api-change.md`、`db-change.md`、`config-change.md`。
- 不修改业务代码。
- 不自行将 `plan.md` 改为 `Reviewed`。
- 已 Reviewed 的 `plan.md` 需要修改时，必须先回退。

## Output

回复必须包含：

- 本命令完成了什么：生成、更新或回退 `plan.md`。
- 修改了哪些文件。
- 当前 feature 路径。
- 已生成或更新的 `plan.md`。
- 影响模块。
- 需要人工 review 的重点。
- 当前 feature 处于什么状态：`plan.md` 必须仍为 `Draft`。
- 是否满足下一阶段门禁：通常不满足，必须等待人工 review。
- 下一步应该执行什么命令：人工 review `plan.md`，改为 `Status: Reviewed` 后执行 `sdd-tasks`。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
