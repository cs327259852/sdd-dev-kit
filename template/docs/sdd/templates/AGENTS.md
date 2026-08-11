# SDD Templates

本目录存放 SDD 产物模板。

模板生成的 feature 文档必须遵守以下状态门禁。

## Status Gates

| File | Draft Status | Human Gate | AI Must Not |
| --- | --- | --- | --- |
| `spec.md` | `Draft` | `Confirmed` | AI 不得自行 Confirmed |
| `plan.md` | `Draft` | `Reviewed` | AI 不得自行 Reviewed |
| `tasks.md` | `Draft` | `Approved` | AI 不得自行 Approved |

## Reopen Rules

如果已通过人工门禁的文件需要修改，必须回退状态并记录 Reopen History。

- 修改 `spec.md`：`spec.md -> Draft`，同时 `plan.md`、`tasks.md` 回退。
- 修改 `plan.md`：`plan.md -> Draft`，同时 `tasks.md` 回退。
- 修改 `tasks.md` 或 tasks 阶段交付物：`tasks.md -> Draft`。

回退记录格式：

```md
| Date | From | To | Reason | By |
| --- | --- | --- | --- | --- |
| {yyyy-mm-dd} | {from} | Draft | {回退原因} | {name} |
```

## Template Usage

- 首次生成 `spec.md` 时，只能生成 `spec.md`。
- `spec.md` 人工 Confirmed 后，才能生成 `plan.md`。
- `plan.md` 人工 Reviewed 后，才能生成 `tasks.md`。
- `tasks.md` 生成或更新时，必须按 `plan.md` 影响范围同步处理条件性交付物：
  - API 变更生成或更新 `api-change.md`，模板为 `api-change-template.md`。
  - 数据库变更生成或更新 `db-change.md`，模板为 `db-change-template.md`。
  - 配置变更生成或更新 `config-change.md`，模板为 `config-change-template.md`。
- `tasks.md` 人工 Approved 后，才能修改业务代码。
- `validate.md` 只记录 feature 执行验证结果；模块级验证要求在 `docs/sdd/modules/{module}/validate.md`。

## Task Stage Delivery Artifacts

`api-change.md`、`db-change.md`、`config-change.md` 是 `sdd-tasks` 阶段的条件性交付物，不单独设置人工状态字段。它们必须随 `tasks.md` 一起 review：

- 若 `tasks.md` 仍为 `Draft`，AI 可以根据 `plan.md` 更新这些交付物。
- 若 `tasks.md` 已为 `Approved`，需要新增或修改这些交付物时，必须先将 `tasks.md` 回退为 `Draft`。
- 不涉及的交付物不得空填；必须在 `tasks.md` 中写明“不适用”原因。
- 所有交付物不得记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证。

## Open Questions

`spec.md` 中的 Open Questions 必须由人工关闭，AI 不得自行关闭。

未关闭问题格式：

```md
- [ ] Q: {待确认问题}
```

关闭问题时，人工把勾选状态改为 `[x]`，并补充答案：

```md
- [x] Q: {待确认问题}
  A: {确认后的答案或决策}
```

只有所有 Open Questions 都为 `[x]`，且答案足以支撑实现和验证时，`spec.md` 才能改为 `Status: Confirmed`。
