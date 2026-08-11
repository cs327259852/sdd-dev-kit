# Plan: {Feature Name}

## 0. Review Status

- Status: Draft
- Reviewed By:
- Reviewed At:

说明：

状态门禁和回退规则见 `docs/sdd/templates/AGENTS.md`。

### Reopen History

| Date | From | To | Reason | By |
| --- | --- | --- | --- | --- |
| {yyyy-mm-dd} | Reviewed | Draft | {回退原因} | {name} |

## 1. Preconditions

- Feature 目录：`docs/sdd/features/{yyyy-mm-dd}-{feature-name}/`
- 关联 Spec：`spec.md`
- Spec 状态：`Draft / Confirmed`

进入实现前必须满足：

- [ ] `spec.md` 中 `Status: Confirmed`
- [ ] `Confirmed By` 非空
- [ ] `Confirmed At` 非空
- [ ] 无未关闭的 Open Questions

## 2. Current Code

本次变更涉及的现有代码：

| 层级 | 文件 / 类 / 方法 | 当前行为摘要 |
| --- | --- | --- |
| Controller | `{path}` | `{摘要}` |
| Service | `{path}` | `{摘要}` |
| Mapper / XML | `{path}` | `{摘要}` |
| Entity / DTO / Request / VO | `{path}` | `{摘要}` |
| Config / Listener / Util | `{path}` | `{摘要}` |

相关 SDD 文档：

- `docs/sdd/modules/{module}/current.md`
- `docs/sdd/modules/{module}/validate.md`
- `docs/sdd/modules/{module}/history.md`

## 3. Design

实现方案：

1. {步骤 1}
2. {步骤 2}
3. {步骤 3}

关键设计说明：

```text
{说明为什么这样实现，特别是跨模块、事务、异步、缓存、ES、权限和兼容性。}
```

## 4. Impact Analysis

| 影响项 | 是否涉及 | 说明 |
| --- | --- | --- |
| API | 是 / 否 | {说明} |
| MySQL | 是 / 否 | {说明} |
| ES | 是 / 否 | {说明} |
| Redis | 是 / 否 | {说明} |
| RocketMQ | 是 / 否 | {说明} |
| 权限 / 登录 / SSO | 是 / 否 | {说明} |
| 数据库密码链路 | 是 / 否 | {说明} |
| OSS / 文件 | 是 / 否 | {说明} |
| 配置项 | 是 / 否 | {说明} |
| architecture.md | 是 / 否 | {是否改变架构边界、分层、关键链路或外部依赖} |
| domain-map.md | 是 / 否 | {是否新增 / 调整业务域、模块职责、代码入口或数据对象映射} |
| glossary.md | 是 / 否 | {是否新增 / 调整业务术语、状态、缩写或关键字段口径} |
| constitution.md | 是 / 否 | {是否改变工程红线、协作规则、安全规则或技术原则；普通业务需求通常为否} |

tasks 阶段交付物判断：

- [ ] 涉及 API 变更，后续 `sdd-tasks` 需生成或更新 `api-change.md`
- [ ] 涉及 DB 变更，后续 `sdd-tasks` 需生成或更新 `db-change.md`
- [ ] 涉及配置变更，后续 `sdd-tasks` 需生成或更新 `config-change.md`
- [ ] 涉及项目级事实源变更，后续 `sdd-tasks` 需在 `tasks.md` 声明影响并拆出文档更新任务
- [ ] 不涉及上述交付物，需在 `tasks.md` 说明不适用原因

## 5. Data And Transaction Plan

数据库变更：

- [ ] 无表结构变更
- [ ] 有表结构、索引、初始化数据、修复脚本或回滚 SQL 变更，需在 tasks 阶段补充 `db-change.md`

配置变更：

- [ ] 无配置变更
- [ ] 有 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置变更，需在 tasks 阶段补充 `config-change.md`

事务边界：

```text
{说明哪些写操作必须在同一事务中完成，哪些允许最终一致。}
```

数据兼容或迁移：

```text
{说明存量数据如何兼容，是否需要初始化或修复脚本。}
```

## 6. Security Plan

- [ ] 不打印密码、Token、密钥、数据库凭证
- [ ] 不从接口返回数据库密码
- [ ] 新增接口鉴权策略明确
- [ ] 用户输入有校验
- [ ] SQL 使用参数绑定

说明：

```text
{如涉及权限、SSO、Token、数据库密码，需要说明链路和风险。}
```

## 7. Quality Attribute Plan

### 7.1 Minimal Impact Plan

```text
{说明本次实现如何限制影响范围；哪些接口、字段、状态、配置、数据结构、模块和旧行为明确不改。}
```

### 7.2 Extensibility Plan

```text
{说明是否复用现有扩展点，是否新增抽象 / 配置 / 依赖；新增时说明必要性、替代方案和后续扩展方式；不涉及时说明原因。}
```

### 7.3 Robustness And Exception Boundary Plan

| 边界类型 | 是否涉及 | 处理方式 |
| --- | --- | --- |
| 空值 / 缺失字段 | 是 / 否 | {说明} |
| 非法输入 / 非法状态 | 是 / 否 | {说明} |
| 外部依赖失败 / 超时 | 是 / 否 | {说明} |
| 并发 / 重复提交 / 重复消费 | 是 / 否 | {说明} |
| 部分成功 / 事务回滚 / 最终一致 | 是 / 否 | {说明} |
| 资源释放 / 连接关闭 / 临时状态清理 | 是 / 否 | {说明} |

### 7.4 Performance And Capacity Plan

```text
{说明批量规模、分页、循环复杂度、远程调用次数、文件大小、ES / Redis / MQ / DB 访问次数、内存占用等风险和验证方式；不涉及时说明原因。}
```

### 7.5 Maintainability And Readability Plan

- [ ] 职责边界保持清晰，没有把业务分支放入 Controller / DTO / Mapper / Util 的错误层级。
- [ ] 关键业务规则、状态流转、异常边界、排序 / 解析 / 加密 / 并发等非显然逻辑需要中文注释。
- [ ] 未新增不必要依赖、全局状态或跨模块耦合。
- [ ] 重复逻辑可接受；如新增抽象，已说明收益大于复杂度。

说明：

```text
{说明哪些关键代码需要中文注释，哪些复杂度或重复逻辑是可接受的。}
```

## 8. Risks

| Risk | Level | Mitigation |
| --- | --- | --- |
| {风险} | High / Medium / Low | {缓解方式} |

## 9. Validation Plan

验证必须从 `spec.md` 的 Acceptance Criteria 和 Success Metrics 推导，不得只写笼统的“已测试”。

需要执行的验证：

- [ ] `{project build command}`
- [ ] `{project lint/static check command，如适用}`
- [ ] `{project test command}`
- [ ] API 验证
- [ ] 存储层验证
- [ ] 缓存 / 消息 / 搜索 / 文件存储验证，如适用
- [ ] 权限 / SSO / Token 验证
- [ ] 数据库密码链路验证
- [ ] 最小影响范围验证
- [ ] 异常边界验证
- [ ] 性能 / 容量验证
- [ ] 可读性 / 中文注释检查

验收条件映射：

| AC / Metric | 验证方式 | 是否需要自动化测试 | 证据 |
| --- | --- | --- | --- |
| AC-1 | 单元测试 / 接口测试 / 手工验证 | 是 / 否，原因 | {命令 / 接口响应 / 日志 / 截图} |
| Metric-1 | 性能验证 / 数据验证 / 手工验证 | 是 / 否，原因 | {命令 / 指标 / 截图} |

自动化测试策略：

```text
{说明哪些逻辑需要补单元测试、Controller 测试或集成测试；这些测试应在 tasks.md 中拆成编码任务，并在编码阶段实现。如果不补自动化测试，说明原因。}
```

不可自动化验证项：

```text
{说明依赖外部环境、SSO、RocketMQ、Redis、ES、数据库实例等导致无法自动化的验证项，以及替代验证方式。}
```

## 10. Rollback Plan

```text
{说明如果上线后失败，如何回滚代码、配置、数据或异步状态。}
```
