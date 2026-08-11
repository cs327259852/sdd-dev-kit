# Module Current: {module}

本文档记录 `{module}` 模块当前真实行为。

要求：

- 只描述当前代码和线上应表现出的真实行为。
- 不记录流水账历史。
- 无法确认的模块职责、业务规则或边界写入 Open Questions。

## 1. Module Scope

| 项 | 内容 |
| --- | --- |
| 模块名称 | `{module}` |
| 主要职责 | `{responsibility}` |
| 非职责范围 | `{non-goals}` |
| 证据来源 | `{source}` |

## 2. Code Entry Points

| 类型 | 路径 / 类 / 函数 | 职责 |
| --- | --- | --- |
| Controller / Route / Handler | `{path}` | `{职责}` |
| Service / Usecase | `{path}` | `{职责}` |
| Repository / DAO / Mapper | `{path}` | `{职责}` |
| Job / Listener / Consumer | `{path}` | `{职责}` |

## 3. Current Behavior

### 3.1 `{行为名称}`

- 入口：`{entry}`
- 当前行为：`{behavior}`
- 边界：`{boundary}`
- 异常处理：`{error handling}`

## 4. Data Objects

| 对象 / 表 / 集合 | 用途 | 关键字段 |
| --- | --- | --- |
| `{object}` | `{purpose}` | `{fields}` |

## 5. State And Rules

| Rule ID | 规则 | 来源 |
| --- | --- | --- |
| `{rule id}` | `{rule}` | `{source}` |

## 6. Dependencies

| 依赖 | 用途 | 失败影响 |
| --- | --- | --- |
| `{dependency}` | `{purpose}` | `{failure impact}` |

## 7. Security And Permissions

- 登录要求：`{requirement}`
- 权限要求：`{permission}`
- 敏感数据：`{sensitive data}`
- 日志要求：`{logging rule}`

## 8. Maintenance Rules

- feature 上线或合并后，必须覆盖更新为最新事实。
- 不要把历史变更过程追加到本文档。
- 如果代码和本文档冲突，必须停止并报告冲突点。

## 9. Open Questions

- [ ] Q: `{待确认模块事实}`
