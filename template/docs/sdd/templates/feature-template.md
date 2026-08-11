# Feature Directory Template

本模板用于说明标准 feature 目录结构和产物生成顺序。

## 1. Directory

目录命名：

```text
docs/sdd/features/{yyyy-mm-dd}-{feature-name}/
```

命名规则：

- `{yyyy-mm-dd}` 使用创建日期。
- `{feature-name}` 使用小写英文、数字和短横线。
- 不使用中文、空格、下划线。
- 同一需求只创建一个 feature 目录。

示例：

```text
docs/sdd/features/2026-05-09-menu-permission-refine/
```

## 2. Files

`sdd-use` 只负责选择或创建 feature 目录，不生成阶段产物。

首次生成阶段产物时，只生成：

```text
spec.md
```

`spec.md` 来源：

| 文件 | 模板 |
| --- | --- |
| `spec.md` | `docs/sdd/templates/spec-template.md` |

后续阶段按门禁逐步生成：

| 阶段 | 前置条件 | 生成文件 | 模板 |
| --- | --- | --- | --- |
| 方案设计 | `spec.md` 已人工确认，`Status: Confirmed` | `plan.md` | `docs/sdd/templates/plan-template.md` |
| 任务拆解 | `plan.md` 已人工 review | `tasks.md` | `docs/sdd/templates/tasks-template.md` |
| 任务拆解：接口变更 | `plan.md` 影响分析涉及 API | `api-change.md` | `docs/sdd/templates/api-change-template.md` |
| 任务拆解：数据库变更 | `plan.md` 影响分析涉及表结构、索引、初始化数据、修复脚本或回滚 SQL | `db-change.md` | `docs/sdd/templates/db-change-template.md` |
| 任务拆解：配置变更 | `plan.md` 影响分析涉及 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置 | `config-change.md` | `docs/sdd/templates/config-change-template.md` |
| 验证记录 | 已有实现或明确验证计划 | `validate.md` | `docs/sdd/templates/validate-template.md` |

统一使用 `tasks.md`，不要使用 `task.md`。

`api-change.md`、`db-change.md`、`config-change.md` 是 `sdd-tasks` 阶段的条件性交付物。是否生成必须以 `plan.md` 的影响分析为依据；不涉及时必须在 `tasks.md` 说明不适用原因。

## 3. AI Generation Rules

AI 生成 feature 产物时必须遵守：

1. 遵循 `AGENTS.md` 中定义的读取顺序和模块映射。
2. 先读取 `docs/sdd/templates/AGENTS.md`。
3. 使用本目录下的模板生成 `spec.md`。
4. `spec.md` 默认只能生成 `Status: Draft`。
5. AI 不得自行把 `spec.md` 改为 `Confirmed`。
6. 如果需求描述不足，必须在 `spec.md` 的 `Open Questions` 中列出，不得靠猜测补齐。
7. 首次生成产物时，不得同时生成 `plan.md`、`tasks.md`、`validate.md`。
8. `plan.md` 只有在 `spec.md` 人工确认后才能生成。
9. `tasks.md` 只有在 `plan.md` 人工 review 后才能生成。
10. `api-change.md`、`db-change.md`、`config-change.md` 只能在 `sdd-tasks` 阶段按影响范围生成或更新。
11. 上述交付物不得记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证。

## 4. AI Output Reminder

AI 创建 `spec.md` 后，最终回复中必须提醒用户 review 以下内容：

- 背景和问题是否准确。
- Goals / Non-Goals 是否完整。
- Success Metrics 是否可衡量。
- Acceptance Criteria 是否可验证。
- 影响模块是否遗漏。
- 权限、安全、数据兼容是否明确。
- 最小影响范围是否明确。
- 可扩展性、异常边界、性能 / 容量、可维护性 / 可读性要求是否明确；不涉及时是否说明原因。
- Open Questions 是否全部关闭。

同时提醒用户：确认后需要由人工修改 `spec.md` 的确认状态：

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```
