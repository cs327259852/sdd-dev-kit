# Feature: {Feature Name}

## 0. Confirmation

- Status: Draft
- Confirmed By:
- Confirmed At:

说明：

状态门禁和回退规则见 `docs/sdd/templates/AGENTS.md`。

### Reopen History

| Date | From | To | Reason | By |
| --- | --- | --- | --- | --- |
| {yyyy-mm-dd} | Confirmed | Draft | {回退原因} | {name} |

## 1. Background

当前问题或需求背景：

```text
{说明为什么要做这个需求。需要基于用户提供的信息和现有代码，不要猜测业务目标。}
```

## 2. Problem Statement

需要解决的问题：

```text
{用清晰、可验证的语言描述问题。}
```

## 3. Goals

- [ ] {目标 1}
- [ ] {目标 2}
- [ ] {目标 3}

## 4. Success Metrics

用于衡量本 feature 是否成功：

- {指标 1，例如：接口 P95 响应时间不超过 300ms}
- {指标 2，例如：存量调用方无需修改请求参数}
- {指标 3，例如：目标场景人工操作步骤减少到 3 步以内}

## 5. Non-Goals

本次明确不做：

- {不做事项 1}
- {不做事项 2}

## 6. User Stories

1. 作为 {角色}，我希望 {能力}，以便 {价值}。
2. 作为 {角色}，我希望 {能力}，以便 {价值}。

## 7. Acceptance Criteria

- [ ] AC-1: {验收条件，需要能被接口测试、单测或手工验证证明}
- [ ] AC-2: {验收条件}
- [ ] AC-3: {验收条件}

## 8. Impact Scope

预计影响模块：

- [ ] `account`
- [ ] `sso-auth`
- [ ] `permission`
- [ ] `menu`
- [ ] `storage`
- [ ] `es-storage`
- [ ] `database-instance`
- [ ] `db-password`
- [ ] `product-environment`
- [ ] `release-plan`
- [ ] `release-audit`
- [ ] `release-task`
- [ ] `sql-script`
- [ ] `sql-execution`
- [ ] `file-oss`

预计影响接口：

| Method | Path | 兼容性说明 |
| --- | --- | --- |
| `{GET/POST}` | `{path}` | `{不变 / 新增 / 兼容变更 / 不兼容变更}` |

预计影响数据：

- [ ] MySQL 表结构
- [ ] MySQL 数据读写语义
- [ ] ES 索引 / 字段 / 查询
- [ ] Redis key / 状态
- [ ] RocketMQ topic / message
- [ ] OSS 文件路径 / 文件格式
- [ ] 配置项
- [ ] 无数据影响

## 9. Business Rules

| Rule ID | 规则 | 来源 |
| --- | --- | --- |
| BR-1 | {业务规则} | {人工需求 / current.md / 代码位置} |

## 10. Permission And Security

- 登录要求：{是否需要登录}
- 权限要求：{角色 / 菜单按钮 / @Permit / 无}
- 敏感数据：{密码 / Token / 密钥 / 数据库连接 / 无}
- 日志要求：{哪些字段不能打印}

## 11. Quality Attributes

本 feature 对质量属性的要求：

- 最小影响范围：{明确哪些模块、接口、字段、配置、数据和行为不能改；不涉及则说明}
- 可扩展性：{是否需要扩展点、配置化、抽象复用、预留多类型支持；不涉及则说明}
- 健壮性 / 异常边界：{空值、非法输入、外部依赖失败、并发、重试、部分成功、资源释放等边界}
- 性能 / 容量：{接口响应、批量规模、分页、文件大小、循环、远程调用、ES / Redis / MQ / DB 访问等要求}
- 可维护性 / 可读性：{关键业务规则、状态流转、异常边界、排序/解析/加密/并发等是否需要中文注释}

## 12. Compatibility

- 请求路径是否兼容：{是 / 否 / 不涉及}
- 请求字段是否兼容：{是 / 否 / 不涉及}
- 响应字段是否兼容：{是 / 否 / 不涉及}
- 错误码是否兼容：{是 / 否 / 不涉及}
- 存量数据是否兼容：{是 / 否 / 不涉及}

不兼容变更说明：

```text
{如存在不兼容变更，必须说明原因、影响范围和迁移方式。}
```

## 13. Constraints

- 使用项目现有技术栈和现有模块边界。
- 不引入新依赖，除非在 `plan.md` 中说明必要性并经过人工确认。
- 不改变未列入本 spec 的业务行为。

其他约束：

- {约束 1}

## 14. Open Questions

- [ ] Q: {待确认问题 1}
- [ ] Q: {待确认问题 2}

关闭格式：

```md
- [x] Q: {待确认问题}
  A: {确认后的答案或决策}
```

如果存在未关闭问题，`Status` 不得改为 `Confirmed`。
