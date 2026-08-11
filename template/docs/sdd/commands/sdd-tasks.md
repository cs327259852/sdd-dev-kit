# sdd-tasks

基于已 Reviewed 的 `plan.md` 生成 Draft `tasks.md`，并按影响范围生成 tasks 阶段交付物，或回退 `tasks.md`。

## Input

生成 tasks：

```text
sdd-tasks
```

回退 tasks：

```text
sdd-tasks rollback
{回退原因}
```

## Preconditions

读取当前 feature 的 `plan.md`，必须满足：

- `Status: Reviewed`
- `Reviewed By` 非空
- `Reviewed At` 非空

同时确认 `spec.md` 仍为 `Status: Confirmed`。

任一不满足，停止，不生成 `tasks.md`。

## Generate Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `spec.md` 和 `plan.md`。
3. 读取相关模块 `validate.md`。
4. 使用 `docs/sdd/templates/tasks-template.md` 生成或更新 `tasks.md`。
5. 根据 `plan.md` 的 Impact Analysis 和 Data And Transaction Plan 同步生成或更新 feature 目录下的交付物：
   - 涉及新增、修改或删除接口时，使用 `docs/sdd/templates/api-change-template.md` 生成或更新 `api-change.md`。
   - 涉及表结构、索引、初始化数据、修复脚本或回滚 SQL 时，使用 `docs/sdd/templates/db-change-template.md` 生成或更新 `db-change.md`。
   - 涉及 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置时，使用 `docs/sdd/templates/config-change-template.md` 生成或更新 `config-change.md`。
6. 在 `tasks.md` 中把上述交付物的编写、review 和验证拆成明确任务；不涉及的交付物必须在 `tasks.md` 中说明“不适用”原因。
7. 必须在 `tasks.md` 中增加 Project Docs Impact 判断，明确 `architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md` 是否适用及原因。
8. Project Docs Impact 只声明影响并拆出任务，`sdd-tasks` 阶段不得直接修改上述项目级事实源。
9. 任一项目级文档适用时，必须把对应更新拆成 Implementation Task，并要求 `sdd-apply` 执行、`sdd-validate` 核对一致性。
10. 必须把质量属性实现检查拆成任务，覆盖最小影响、异常边界、性能 / 容量、关键中文注释和可读性。
11. 必须把自动化测试、SDD 验证、更新 `validate.md/current.md/history.md` 拆成任务。
12. 保持：

```md
- Status: Draft
- Approved By:
- Approved At:
```

## Delivery Artifacts

`sdd-tasks` 阶段的 feature 目录可包含以下交付物：

| 文件 | 触发条件 | 内容要求 |
| --- | --- | --- |
| `api-change.md` | 修改接口路径、方法、鉴权、请求字段、响应字段、错误码或兼容语义 | 记录接口清单、请求/响应摘要、鉴权策略、兼容性、错误码和验证方式 |
| `db-change.md` | 修改表结构、索引、初始化数据、修复脚本或回滚 SQL | 记录 DDL/DML、执行顺序、兼容策略、回滚 SQL 和验证方式 |
| `config-change.md` | 新增或修改 Nacos、Redis、RocketMQ、RabbitMQ、ES mapping / 索引模板 / alias、环境变量、JVM 参数或其他配置 | 按配置类型标注来源，例如 Nacos 修改、Redis key 修改、RocketMQ topic 增加、RabbitMQ exchange / queue / routing key 增加、ES mapping 修改，并记录默认值、作用域、回滚方式和验证方式 |

交付物规则：

- 交付物必须与 `plan.md` 的影响分析一致，不得新增超出 `spec.md` 和 `plan.md` 的范围。
- 交付物只记录结构、字段、key、topic、默认值和操作步骤，不得记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证。
- 如果已 Approved 的 `tasks.md` 或上述交付物需要修改，必须先回退 `tasks.md`。

## Project Docs Impact

`tasks.md` 必须包含项目级文档影响判断：

| 文件 | 适用条件 | tasks 阶段要求 |
| --- | --- | --- |
| `docs/sdd/architecture.md` | 改变架构边界、分层、关键链路、外部依赖、认证 / 权限 / SQL 执行 / 文件处理等关键机制 | 标明适用章节和更新原因，并拆出文档更新任务 |
| `docs/sdd/domain-map.md` | 新增、拆分、合并模块，调整模块职责、业务域、代码入口或数据对象映射 | 标明影响的业务域、模块和入口，并拆出文档更新任务 |
| `docs/sdd/glossary.md` | 新增或调整业务术语、状态值、缩写、关键字段口径，或术语需跨模块统一 | 标明术语和口径变化，并拆出文档更新任务 |
| `docs/sdd/constitution.md` | 改变工程红线、协作规则、安全规则或技术原则 | 标明必要性；普通业务需求通常不适用 |

规则：

- `sdd-tasks` 只更新 `tasks.md` 和适用的 feature 交付物，不直接修改项目级文档。
- 不适用的项目级文档必须写明原因。
- 已 Approved 后需要新增、删除或修改 Project Docs Impact，必须先回退 `tasks.md`。
- 如果 `sdd-apply` 已经修改项目级文档，后续发现需要回退，不得静默撤销；必须按问题归属回退 `tasks.md`、`plan.md` 或 `spec.md`，重新通过人工门禁后再修正文档。

## Rollback Behavior

当用户要求回退 `tasks.md` 时：

1. 停止编码或验证。
2. 读取 `tasks.md` 以及已存在的 `api-change.md`、`db-change.md`、`config-change.md`。
3. 将 `tasks.md` 的 `Status` 改为 `Draft`。
4. 清空 `Approved By` 和 `Approved At`。
5. 在 `tasks.md` 的 Reopen History 追加记录。
6. 根据回退原因修改 `tasks.md`，包括 Project Docs Impact 和对应项目级文档更新任务。
7. 如果回退前已经修改了项目级文档，保留现有文件改动，不静默撤销；待 `tasks.md` 重新 Approved 后按最新任务修正。
8. 提醒用户重新 approve `tasks.md`。

## Forbidden

- 不修改业务代码。
- 不自行将 `tasks.md` 改为 `Approved`。
- 已 Approved 的 `tasks.md` 需要修改时，必须先回退。
- 已 Approved 后需要新增或修改 `api-change.md`、`db-change.md`、`config-change.md` 时，必须先回退 `tasks.md`。
- `sdd-tasks` 阶段不直接修改 `architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md`。
- 已 Approved 后需要新增、删除或修改 Project Docs Impact 时，必须先回退 `tasks.md`。

## Output

回复必须包含：

- 本命令完成了什么：生成、更新或回退 `tasks.md`。
- 修改了哪些文件。
- 当前 feature 路径。
- 已生成或更新的 `tasks.md`。
- 已生成、更新或判定不适用的交付物：`api-change.md`、`db-change.md`、`config-change.md`。
- 项目级文档影响判断：`architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md` 是否适用及原因。
- 测试和验证任务摘要。
- 当前 feature 处于什么状态：`tasks.md` 必须仍为 `Draft`。
- 是否满足下一阶段门禁：通常不满足，必须等待人工确认。
- 下一步应该执行什么命令：人工 review `tasks.md` 和适用的 `api-change.md`、`db-change.md`、`config-change.md`，将 `tasks.md` 改为 `Status: Approved` 后执行 `sdd-apply`。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
