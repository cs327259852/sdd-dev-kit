# Tasks: {Feature Name}

## 0. Execution Status

- Status: Draft
- Approved By:
- Approved At:

说明：

状态门禁和回退规则见 `docs/sdd/templates/AGENTS.md`。

### Reopen History

| Date | From | To | Reason | By |
| --- | --- | --- | --- | --- |
| {yyyy-mm-dd} | Approved | Draft | {回退原因} | {name} |

## 1. Preconditions

- [ ] `spec.md` 已人工确认，状态为 `Confirmed`
- [ ] `plan.md` 已人工 review，状态为 `Reviewed`
- [ ] 已阅读相关模块的 `current.md`
- [ ] 已阅读相关模块的 `validate.md`

未满足以上条件时，不得开始编码。

## 2. Stage Delivery Artifacts

根据 `plan.md` 的 Impact Analysis 判断本 feature 是否需要以下交付物。

| 交付物 | 是否适用 | 依据 | 状态 / 说明 |
| --- | --- | --- | --- |
| `api-change.md` | 是 / 否 | API 影响项 | {涉及接口时填写；不涉及时说明原因} |
| `db-change.md` | 是 / 否 | MySQL / Data And Transaction Plan | {涉及 DB 变更时填写；不涉及时说明原因} |
| `config-change.md` | 是 / 否 | 配置项 / Redis / MQ / ES mapping 影响项 | {涉及配置变更时填写；不涉及时说明原因} |

要求：

- 涉及新增、修改或删除接口时，必须生成或更新 `api-change.md`。
- 涉及表结构、索引、初始化数据、修复脚本或回滚 SQL 时，必须生成或更新 `db-change.md`。
- 涉及 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置时，必须生成或更新 `config-change.md`。
- `config-change.md` 必须标注配置类型，例如 Nacos 修改、Redis key 修改、RocketMQ topic 增加、RabbitMQ exchange / queue / routing key 增加、ES mapping / index template / alias 修改。
- 不涉及的交付物必须写明“不适用”原因，不得空缺。
- 交付物不得记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证。

## 3. Project Docs Impact

根据 `spec.md` 和 `plan.md` 判断本 feature 是否影响项目级事实源。`sdd-tasks` 阶段只声明影响并拆任务，不直接修改这些项目级文档；实际修改必须在 `sdd-apply` 阶段按已 Approved 的任务执行。

| 项目级文档 | 是否适用 | 依据 | 状态 / 说明 |
| --- | --- | --- | --- |
| `docs/sdd/architecture.md` | 是 / 否 | 架构边界、分层、关键链路、外部依赖 | {适用时说明需要更新的章节；不适用时说明原因} |
| `docs/sdd/domain-map.md` | 是 / 否 | 业务域、模块职责、代码入口、数据对象映射 | {适用时说明需要更新的映射；不适用时说明原因} |
| `docs/sdd/glossary.md` | 是 / 否 | 业务术语、状态、缩写、关键字段口径 | {适用时说明需要新增或调整的术语；不适用时说明原因} |
| `docs/sdd/constitution.md` | 是 / 否 | 工程红线、协作规则、安全规则、技术原则 | {普通业务需求通常不适用；适用时必须说明必要性} |

要求：

- 任一项目级文档为“是”时，必须在 Implementation Tasks 中拆出对应更新任务。
- 任一项目级文档为“否”时，必须写明不适用原因，不得空缺。
- 已 Approved 后需要新增、删除或修改项目级文档影响判断时，必须先回退 `tasks.md`。
- 如果 `sdd-apply` 已经修改了项目级文档，后续发现需要回退，不得静默撤销；必须按问题归属回退 `tasks.md`、`plan.md` 或 `spec.md`，重新通过人工门禁后再修正文档。

## 4. Implementation Tasks

### Task 1: 生成或更新阶段交付物

- 修改文件（按适用项填写）：
  - `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/api-change.md`
  - `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/db-change.md`
  - `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/config-change.md`
- 工作内容：
  - 按 `plan.md` 的影响分析生成或更新适用的交付物。
  - 对不适用的交付物，在本 `tasks.md` 的 Stage Delivery Artifacts 中说明原因。
  - 接口文档记录接口路径、方法、鉴权、请求字段、响应字段、错误码、兼容性和验证方式。
  - 数据库变更记录 DDL/DML、执行顺序、兼容策略、回滚 SQL 和验证方式。
  - 配置变更按 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置分类记录。
- 完成标准：
  - [ ] 所有适用交付物已生成或更新。
  - [ ] 不适用交付物已有明确原因。
  - [ ] 交付物不包含敏感信息。
- 验证方式：
  - 人工 review `api-change.md`、`db-change.md`、`config-change.md`。

### Task 2: 更新项目级事实源文档（按适用项执行）

- 修改文件（按适用项填写）：
  - `docs/sdd/architecture.md`
  - `docs/sdd/domain-map.md`
  - `docs/sdd/glossary.md`
  - `docs/sdd/constitution.md`
- 工作内容：
  - 按 Project Docs Impact 中声明的适用项更新项目级事实源。
  - `architecture.md` 只记录架构边界、关键链路、外部依赖或分层规则变化。
  - `domain-map.md` 只记录业务域、模块职责、代码入口和数据对象映射变化。
  - `glossary.md` 只记录跨模块需要统一理解的术语、状态、缩写和关键字段口径。
  - `constitution.md` 只在工程红线、协作规则、安全规则或技术原则变化时更新。
- 完成标准：
  - [ ] 适用的项目级文档已与代码、feature 文档和模块文档保持一致。
  - [ ] 不适用的项目级文档已有明确原因。
  - [ ] 未把普通 feature 流水账写入项目级事实源。
- 验证方式：
  - `sdd-validate` 核对项目级文档影响判断与实际 diff 一致。

### Task 3: {任务名称}

- 修改文件：
  - `{path}`
- 工作内容：
  - {具体改动 1}
  - {具体改动 2}
- 完成标准：
  - [ ] {标准 1}
  - [ ] {标准 2}
- 验证方式：
  - {命令 / 测试 / 接口验证}

### Task 4: {任务名称}

- 修改文件：
  - `{path}`
- 工作内容：
  - {具体改动 1}
- 完成标准：
  - [ ] {标准 1}
- 验证方式：
  - {命令 / 测试 / 接口验证}

### Task 5: 补充或更新验证文档

- 修改文件：
  - `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/validate.md`
- 工作内容：
  - 按 `validate-template.md` 记录实际验证结果。
  - 将未执行的验证项说明原因。
- 完成标准：
  - [ ] 验收条件都有对应验证记录。

### Task 6: 质量属性实现检查

- 修改文件：
  - `{implementation paths}`
- 工作内容：
  - 按 `plan.md` 的 Minimal Impact Plan 检查未改动范围，避免修改未列入任务的接口、字段、状态、配置、数据结构和公共行为。
  - 按 Robustness And Exception Boundary Plan 实现空值、非法输入、外部依赖失败、并发、部分成功、资源释放等边界处理。
  - 按 Performance And Capacity Plan 实现必要的分页、批量、缓存、短路、限流、超时或资源控制；不涉及时说明原因。
  - 按 Maintainability And Readability Plan 检查职责边界、重复逻辑和关键代码中文注释。
- 完成标准：
  - [ ] 未扩大 `spec.md` / `plan.md` / `tasks.md` 外的实现范围。
  - [ ] 异常边界已有处理或明确不适用原因。
  - [ ] 性能 / 容量风险已有处理或明确不适用原因。
  - [ ] 关键业务规则、状态流转、异常边界、排序 / 解析 / 加密 / 并发等非显然逻辑已有简洁中文注释。
- 验证方式：
  - 代码 review / 单元测试 / 接口测试 / 手工验证。

### Task 7: 补充自动化测试代码

- 修改文件：
  - `{test path，如 jzt-release-server/src/test/java/...}`
- 工作内容：
  - 根据 `plan.md` 的 Validation Plan 判断是否需要新增或更新测试用例。
  - 优先覆盖可自动化验证的 Acceptance Criteria。
  - 在编码阶段实现测试代码，测试代码和业务代码一起提交。
  - 如果不新增自动化测试，必须在 feature `validate.md` 中说明原因。
- 完成标准：
  - [ ] 需要自动化覆盖的验收条件已有测试。
  - [ ] 不需要自动化覆盖的验收条件已说明原因。
- 验证方式：
  - Step 9A 执行 `./gradlew :jzt-release-server:test`

### Task 8: 执行 SDD 验证

- 修改文件：
  - `docs/sdd/features/{yyyy-mm-dd}-{feature-name}/validate.md`
- 工作内容：
  - 读取 `spec.md` 的 Acceptance Criteria 和 Success Metrics。
  - 读取 `plan.md` 的 Validation Plan。
  - 读取 `tasks.md` 的 Validation Tasks。
  - 读取适用的 `api-change.md`、`db-change.md`、`config-change.md`。
  - 核对 Project Docs Impact 中适用的项目级文档是否已更新且与代码一致。
  - 读取相关模块的 `validate.md`。
  - 执行编译、测试、接口验证、专项验证。
  - 记录最小影响、异常边界、性能 / 容量、可读性 / 中文注释检查结果。
  - 将验证结果、证据和未执行原因写入 feature `validate.md`。
- 完成标准：
  - [ ] 每条 Acceptance Criteria 都有验证结果。
  - [ ] 每条 Success Metrics 都有验证结果或未执行原因。
  - [ ] 未执行验证均说明原因。

### Task 9: 更新模块 current.md

- 修改文件：
  - `docs/sdd/modules/{module}/current.md`
- 工作内容：
  - 覆盖更新为上线后的真实行为。
  - 不追加流水账历史。
- 完成标准：
  - [ ] `current.md` 与代码真实行为一致。

### Task 10: 更新模块 history.md

- 修改文件：
  - `docs/sdd/modules/{module}/history.md`
- 工作内容：
  - 记录本 feature、状态、摘要、spec 路径、branch、commit。
- 完成标准：
  - [ ] 每个受影响模块都有 history 记录。

## 5. Validation Tasks

- [ ] 已读取 `spec.md` 的 Acceptance Criteria
- [ ] 已读取 `spec.md` 的 Success Metrics
- [ ] 已读取 `plan.md` 的 Validation Plan
- [ ] 已读取相关模块的 `validate.md`
- [ ] 核对 `api-change.md`、`db-change.md`、`config-change.md` 与代码和配置变更一致
- [ ] 核对 Project Docs Impact 中适用的项目级文档与代码、feature 文档和模块文档一致
- [ ] 核对 Project Docs Impact 中不适用的项目级文档确有不适用原因
- [ ] 编译 `jzt-release-infra`
- [ ] 编译 `jzt-release-server`
- [ ] 执行相关测试
- [ ] 新增或更新必要的自动化测试
- [ ] 验证最小影响范围
- [ ] 验证异常边界
- [ ] 验证性能 / 容量风险或记录不适用原因
- [ ] 检查关键代码中文注释和可读性
- [ ] 验证 API 正常场景
- [ ] 验证 API 异常场景
- [ ] 验证权限不足场景
- [ ] 检查敏感日志
- [ ] 按受影响模块的 `validate.md` 执行专项验证

## 6. Done Checklist

- [ ] 代码实现完成
- [ ] 适用的 `api-change.md` 已更新，或不适用原因已记录
- [ ] 适用的 `db-change.md` 已更新，或不适用原因已记录
- [ ] 适用的 `config-change.md` 已更新，或不适用原因已记录
- [ ] 适用的项目级文档已更新，或不适用原因已记录
- [ ] 必要自动化测试已补充，或未补充原因已记录
- [ ] 最小影响范围已确认
- [ ] 异常边界已处理或不适用原因已记录
- [ ] 性能 / 容量风险已验证或不适用原因已记录
- [ ] 关键代码中文注释和可读性已检查
- [ ] 验证完成或未执行原因已说明
- [ ] `validate.md` 已更新
- [ ] 相关模块 `current.md` 已更新
- [ ] 相关模块 `history.md` 已更新
- [ ] 无未确认的业务规则
- [ ] 无新增敏感日志
