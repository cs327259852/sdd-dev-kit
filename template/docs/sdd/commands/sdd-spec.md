# sdd-spec

在当前 feature 目录下生成 Draft `spec.md`，或回退 `spec.md`。

## Input

生成 spec：

```text
sdd-spec
{需求描述}
```

回退 spec：

```text
sdd-spec rollback
{回退原因}
```

完整自然语言也支持。

## Preconditions

必须存在：

- `AGENTS.md`
- `docs/sdd/workflow.md`
- `docs/sdd/templates/spec-template.md`
- `docs/sdd/modules/`
- 当前 feature 目录

如果没有当前 feature，停止并要求先执行 `sdd-use {feature}`。

## Generate Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `docs/sdd/domain-map.md`，判断受影响模块。
3. 读取相关模块的 `current.md`、`validate.md`、`history.md`。
4. 使用 `docs/sdd/templates/spec-template.md` 生成当前 feature 的 `spec.md`。
5. 在 `spec.md` 中明确最小影响范围、可扩展性、健壮性 / 异常边界、性能 / 容量、可维护性 / 可读性和安全性要求；不涉及时写明原因。
6. 保持：

```md
- Status: Draft
- Confirmed By:
- Confirmed At:
```

## Rollback Behavior

当用户要求回退 `spec.md` 时：

1. 停止编码或验证。
2. 读取 `spec.md`、`plan.md`、`tasks.md` 以及已存在的 `api-change.md`、`db-change.md`、`config-change.md`。
3. 将 `spec.md` 的 `Status` 改为 `Draft`。
4. 清空 `Confirmed By` 和 `Confirmed At`。
5. 在 `spec.md` 的 Reopen History 追加记录。
6. 如果存在 `plan.md`，将 `plan.md` 回退为 `Draft`，清空 `Reviewed By/Reviewed At`，并记录 `Spec reopened`。
7. 如果存在 `tasks.md`，将 `tasks.md` 回退为 `Draft`，清空 `Approved By/Approved At`，并记录 `Spec reopened`。
8. 如果存在 `api-change.md`、`db-change.md`、`config-change.md`，提醒这些交付物需在重新执行 `sdd-tasks` 时按新 spec / plan 复核或更新。
9. 根据回退原因修改 `spec.md`。
10. 提醒用户重新确认 `spec.md`。

## Forbidden

- 不创建或切换 feature 目录。
- 不生成 `plan.md`、`tasks.md`、`api-change.md`、`db-change.md`、`config-change.md`、`validate.md`。
- 不修改业务代码。
- 不更新模块 `current.md` 或 `history.md`。
- 不自行将 `spec.md` 改为 `Confirmed`。

## Output

回复必须包含：

- 本命令完成了什么：生成或回退 `spec.md`。
- 修改了哪些文件。
- 当前 feature 路径。
- 已创建或更新的 `spec.md`。
- 推断出的受影响模块。
- 需要人工确认的 Open Questions。
- Open Questions 的关闭方式：人工将问题改为 `[x]`，并补充 `A`。
- 当前 feature 处于什么状态：`spec.md` 必须仍为 `Draft`。
- 是否满足下一阶段门禁：通常不满足，必须等待人工确认。
- 下一步应该执行什么命令：人工 review `spec.md`，改为 `Status: Confirmed` 后执行 `sdd-plan`。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
