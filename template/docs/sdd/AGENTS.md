# SDD AGENTS.md

本文档是进入 SDD 流程后的详细入口。普通问答不要读取本文件；只有根 `AGENTS.md` 路由到 SDD 时读取。

## 0. SDD 只读模式

当用户只是咨询项目现有行为、模块职责、架构判断、业务规则、历史变更或实现原因，且没有要求修改代码或 SDD 产物时，进入 SDD 只读模式。

只读模式要求：

- 按问题范围读取必要的 SDD 事实源，优先读取 `architecture.md`、`domain-map.md`、`glossary.md`、相关模块 `current.md` / `history.md`。
- 只基于已读取的 SDD 文档和代码事实回答；如果事实不足，说明缺口，不自行补业务规则。
- 不修改代码、配置、测试或 SDD 产物。
- 如果咨询过程中用户转为要求修改代码或业务行为，立即切换到完整 SDD 流程并执行阶段门禁。

## 1. 命令入口

工具无关命令规则：

- `docs/sdd/commands/AGENTS.md`
- `docs/sdd/commands/sdd-help.md`
- `docs/sdd/commands/sdd-use.md`
- `docs/sdd/commands/sdd-status.md`
- `docs/sdd/commands/sdd-spec.md`
- `docs/sdd/commands/sdd-plan.md`
- `docs/sdd/commands/sdd-tasks.md`
- `docs/sdd/commands/sdd-apply.md`
- `docs/sdd/commands/sdd-validate.md`
- `docs/sdd/commands/sdd-archive.md`

Codex skill 入口：

- `.codex/skills/sdd-use/SKILL.md`
- `.codex/skills/sdd-help/SKILL.md`
- `.codex/skills/sdd-status/SKILL.md`
- `.codex/skills/sdd-spec/SKILL.md`
- `.codex/skills/sdd-plan/SKILL.md`
- `.codex/skills/sdd-tasks/SKILL.md`
- `.codex/skills/sdd-apply/SKILL.md`
- `.codex/skills/sdd-validate/SKILL.md`
- `.codex/skills/sdd-archive/SKILL.md`

`.codex/skills` 只负责触发 Codex skill；真实命令规则以 `docs/sdd/commands/*` 为准。

## 2. 当前 Feature 解析

阶段命令解析当前 feature 时按以下顺序：

1. 用户本次输入明确指定 `feature=`、feature 目录名、feature 路径或短命令参数。
2. 读取 `.sdd/current-feature`。
3. 如果 `.sdd/current-feature` 不存在，但 `.codex/sdd-current-feature` 存在，可迁移写入 `.sdd/current-feature`。
4. 扫描 `docs/sdd/features/` 中唯一可判断为进行中的 feature。
5. 若不存在或存在多个候选，停止并提示用户先执行 `sdd-use {feature}`。

`.sdd/current-feature` 是本机上下文文件，只用于减少重复输入 feature，不作为团队共享事实源。

## 3. 读取顺序

进入 SDD 后按命令规则渐进读取，避免无关文件一次性进入上下文。

实现或验证业务变更前，按需读取：

1. `docs/sdd/constitution.md`
2. `docs/sdd/architecture.md`
3. `docs/sdd/domain-map.md`
4. `docs/sdd/glossary.md`
5. `docs/sdd/workflow.md`
6. 当前命令对应的 `docs/sdd/commands/{command}.md`
7. `docs/sdd/modules/AGENTS.md`
8. 相关模块的 `current.md`、`validate.md`、`history.md`
9. 当前 feature 的 `spec.md`、`plan.md`、`tasks.md`
10. 当前 feature 适用的 `api-change.md`、`db-change.md`、`config-change.md`、`validate.md`

生成 SDD 产物时，还必须读取：

- `docs/sdd/templates/AGENTS.md`
- `docs/sdd/templates/feature-template.md`
- 对应产物模板，例如 `spec-template.md`、`plan-template.md`、`tasks-template.md`、`validate-template.md`

## 4. 阶段硬门禁

- 没有 Confirmed `spec.md`，不得生成正式 `plan.md`，不得编码。
- 没有 Reviewed `plan.md`，不得生成正式 `tasks.md`，不得编码。
- 没有 Approved `tasks.md`，不得修改业务代码或测试代码。
- 验证失败时不得执行 `sdd-archive`。
- Agent 不得自行把 `spec.md` 改为 `Confirmed`。
- Agent 不得自行把 `plan.md` 改为 `Reviewed`。
- Agent 不得自行把 `tasks.md` 改为 `Approved`。
- 如果代码与 SDD 文档冲突，必须停止并报告冲突点。

## 5. SDD 事实源

项目事实源：

- `constitution.md`：项目级工程规则
- `architecture.md`：技术架构、分层、关键链路和外部依赖
- `domain-map.md`：业务领域、模块、代码入口和数据对象映射
- `glossary.md`：业务术语、状态、缩写和关键字段含义
- `workflow.md`：团队日常 SDD 流程和阶段门禁

模块事实源：

- `modules/AGENTS.md`
- `modules/*/current.md`
- `modules/*/validate.md`
- `modules/*/history.md`

Feature 事实源：

- `features/*/spec.md`
- `features/*/plan.md`
- `features/*/tasks.md`
- `features/*/api-change.md`
- `features/*/db-change.md`
- `features/*/config-change.md`
- `features/*/validate.md`

模板事实源：

- `templates/AGENTS.md`
- `templates/*-template.md`

## 6. 质量和安全底线

- 必须遵守最小影响原则，不修改未列入 `spec.md`、`plan.md`、`tasks.md` 的接口、字段、状态、配置、数据结构或公共行为。
- 必须在 `spec.md`、`plan.md`、`tasks.md`、`validate.md` 中按影响范围说明可扩展性、异常边界、性能 / 容量、可维护性 / 可读性和安全性；不涉及时说明原因。
- 关键业务规则、状态流转、异常边界、排序 / 解析 / 加密 / 并发等非显然逻辑必须有简洁中文注释。
- 编写 SQL 和 Java 代码必须主动评估性能风险，避免 N+1 查询、全表扫描、无界列表加载、循环内 IO / DB / 远程调用和不必要的重复计算；涉及批量、分页、文件解析、SQL 执行或外部依赖时必须说明容量边界和验证方式。
- 对象复制必须使用显式 `set` 方法或 MapStruct；禁止使用 `BeanUtils.copyProperties`、`PropertyUtils.copyProperties`、`BeanCopier` 等反射式、字符串属性名驱动或隐式拷贝工具，除非已在 `plan.md` 中说明必要性并经过人工 Reviewed。
- 实现中发现新的异常边界、性能 / 容量风险、扩展性要求或维护性问题超出已 Approved 的 `tasks.md` 时，必须停止并按 SDD 回退流程处理。
- 不记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证。
- 不从接口返回数据库密码。
- 不绕过 `SecurityUtils` 或 Spring Security 上下文获取当前用户身份。
- 不拼接 SQL 字符串，使用 MyBatis-Plus Wrapper 或 Mapper XML 参数绑定。

## 7. 高风险区域

涉及以下区域必须读取相关模块文档并额外验证：

- SQL 执行
- 数据库密码加密和解密
- SSO / JWT / 登录
- ES 写入、查询、删除
- Redis 任务状态
- RocketMQ 执行
- Mapper XML
- 文件上传 / OSS
- 权限校验

模块映射详见 `docs/sdd/domain-map.md`。

## 8. 输出要求

执行 SDD 命令或修改代码时，最终回复必须包含：

- 修改了哪些代码文件。
- 修改了哪些 SDD 文件。
- 执行了哪些验证命令。
- 验证结果是什么。
- 哪些验证未执行以及原因。
- 是否发现 SDD 与代码冲突。
