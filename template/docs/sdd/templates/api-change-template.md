# API Change: {Feature Name}

本文件记录当前 feature 新增、修改或删除的接口，作为 `sdd-tasks` 阶段交付物。

不得记录密码、Token、密钥、数据库凭证或可复用的生产请求凭据。

## 1. Summary

```text
{说明本次接口变更目标、影响调用方和兼容性结论。}
```

## 2. API List

| Method | Path | Change Type | Auth / Permission | Request Impact | Response Impact | Compatibility |
| --- | --- | --- | --- | --- | --- | --- |
| GET / POST / PUT / DELETE | `{path}` | Added / Modified / Removed | `{权限策略}` | `{请求变化}` | `{响应变化}` | Compatible / Breaking |

## 3. API Details

### {METHOD} {path}

- Change Type: Added / Modified / Removed
- Controller / Method: `{class}#{method}`
- Auth / Permission: `{说明鉴权、@Permit、登录态或放行策略}`
- Caller Impact: `{说明前端、外部系统或其他调用方需要调整什么}`

请求参数：

| Field | Location | Type | Required | Change | Description |
| --- | --- | --- | --- | --- | --- |
| `{field}` | path / query / body / header | `{type}` | Yes / No | Added / Modified / Removed / Unchanged | `{说明}` |

响应字段：

| Field | Type | Change | Description |
| --- | --- | --- | --- |
| `{field}` | `{type}` | Added / Modified / Removed / Unchanged | `{说明}` |

错误码 / 异常：

| Code / Message | Condition | Change | Description |
| --- | --- | --- | --- |
| `{code}` | `{触发条件}` | Added / Modified / Removed / Unchanged | `{说明}` |

兼容性：

```text
{说明旧调用是否兼容；如不兼容，写明迁移方式和影响范围。}
```

验证方式：

```text
{说明正常场景、异常场景、权限场景如何验证。}
```

## 4. Security Notes

- [ ] 新增接口鉴权策略明确。
- [ ] 不从接口返回数据库密码、Token、密钥或敏感凭证。
- [ ] 请求字段已说明校验规则。
- [ ] 权限不足场景已列入验证。

## 5. Consumer Notes

```text
{记录前端、外部系统或接口调用方需要关注的字段、时序、兼容策略。无影响时写“不适用”。}
```
