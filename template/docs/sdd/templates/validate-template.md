# Validate: {Feature Name}

## 1. Validation Scope

本次验证覆盖的变更范围：

- Feature 目录：`docs/sdd/features/{date}-{feature}/`
- 关联 Spec：`spec.md`
- 关联 Plan：`plan.md`
- 关联 Tasks：`tasks.md`
- 关联接口变更：`api-change.md` / 不适用
- 关联数据库变更：`db-change.md` / 不适用
- 关联配置变更：`config-change.md` / 不适用
- 关联项目级文档：
  - `docs/sdd/architecture.md` / 不适用
  - `docs/sdd/domain-map.md` / 不适用
  - `docs/sdd/glossary.md` / 不适用
  - `docs/sdd/constitution.md` / 不适用
- 影响模块：
  - [ ] Controller
  - [ ] Service
  - [ ] Mapper / XML
  - [ ] Entity / DTO / Request / VO
  - [ ] DB Schema / 初始化数据
  - [ ] ES 索引 / 查询 / 写入 / 删除
  - [ ] Redis
  - [ ] RocketMQ
  - [ ] RabbitMQ
  - [ ] SQL 执行器
  - [ ] 密码 / Token / SSO / 权限
  - [ ] OSS / 文件上传
  - [ ] 配置项

## 2. Acceptance Criteria Mapping

| Acceptance Criteria | 验证方式 | 结果 | 证据 |
| --- | --- | --- | --- |
| AC-1: {验收条件} | 单测 / 接口测试 / 手工验证 | PASS / FAIL / N/A | {命令、截图、日志、响应示例} |
| AC-2: {验收条件} | 单测 / 接口测试 / 手工验证 | PASS / FAIL / N/A | {命令、截图、日志、响应示例} |

## 3. Build Validation

### Commands

```bash
./gradlew :jzt-release-infra:compileJava
./gradlew :jzt-release-server:compileJava
```

### Result

- [ ] PASS
- [ ] FAIL
- [ ] NOT RUN

说明：

```text
{粘贴关键错误或通过说明，不需要贴完整日志}
```

## 4. Automated Test Validation

### Commands

```bash
./gradlew :jzt-release-server:test
```

### Result

- [ ] PASS
- [ ] FAIL
- [ ] NOT RUN

未执行原因：

```text
{如果未执行，说明是缺少环境、依赖、时间，还是当前项目无相关测试}
```

## 5. API Validation

涉及接口变更时，必须先核对 `api-change.md`。

| API | 场景 | 请求摘要 | 期望结果 | 实际结果 |
| --- | --- | --- | --- | --- |
| `{METHOD} {PATH}` | 正常场景 | `{}` | `{}` | PASS / FAIL |
| `{METHOD} {PATH}` | 参数缺失 | `{}` | `{}` | PASS / FAIL |
| `{METHOD} {PATH}` | 权限不足 | `{}` | `{}` | PASS / FAIL |

兼容性确认：

- [ ] 已核对 `api-change.md`
- [ ] URL 未变
- [ ] 请求字段兼容
- [ ] 响应字段兼容
- [ ] 错误码 / 错误信息兼容
- [ ] 不兼容变更已在 Spec 中明确

## 6. Storage Validation

涉及存储层时必须填写。

- [ ] 已核对 `db-change.md` 或确认不适用
- [ ] 新增 / 修改 SQL 使用参数绑定
- [ ] 查询逻辑包含必要的逻辑删除条件
- [ ] 分页查询总数和列表正确
- [ ] 批量写入或更新事务边界明确
- [ ] Mapper XML resultMap / DTO 字段映射正确
- [ ] 乐观锁字段 `version` 行为符合预期
- [ ] 公共字段 `createUser/createTime/updateUser/updateTime` 行为符合预期

验证说明：

```text
{说明验证数据、SQL、接口返回或测试用例}
```

## 7. Multi-DB Executor Validation

涉及 SQL 执行器或数据库实例连接时必须填写。

| 数据库类型 | 连接测试 | SQL 成功执行 | SQL 失败中断 | 重复脚本跳过 | 停止任务 | 备注 |
| --- | --- | --- | --- | --- | --- | --- |
| MySQL | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | |
| Oracle | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | |
| SQL Server | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | |

必须确认：

- [ ] `DbSqlExecutorFactory` 能正确选择执行器
- [ ] `DbSqlExecutorUtil.parseDatabaseUrl` 生成 URL 正确
- [ ] 执行失败后子任务状态正确
- [ ] 执行停止后不会继续执行后续 SQL
- [ ] Redis 行号计数在成功结束时清理
- [ ] Redis 并发槽位在 finally 中释放
- [ ] 执行记录写入成功

## 8. ES Storage Validation

涉及任务脚本、脚本执行记录、ES 查询或 ES 写入时必须填写。

| ES 对象 | 索引别名 | 写入验证 | 查询验证 | 删除验证 | 备注 |
| --- | --- | --- | --- | --- | --- |
| 任务脚本明细 | `release_task_script_aliases` | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | |
| 脚本执行记录 | `release_script_execution_record_aliases` | PASS / FAIL / N/A | PASS / FAIL / N/A | PASS / FAIL / N/A | |

必须确认：

- [ ] bulk upsert 成功，无 `BulkResponse#hasFailures`
- [ ] snake_case 字段名与查询字段一致
- [ ] 精确匹配字段使用正确，例如 `script_content.keyword`
- [ ] 任务脚本按 `serial_number` 升序返回
- [ ] 脚本执行记录按 `start_time` 升序返回
- [ ] 重复脚本判断能查到已成功执行记录
- [ ] 删除任务时对应 ES 任务脚本被删除
- [ ] ES 写入失败时有可定位日志或补偿方案
- [ ] ES 与 MySQL 不一致时有人工恢复或重放方案

验证说明：

```text
{说明索引、测试数据、查询条件、响应结果、失败处理}
```

## 9. DB Password Validation

涉及数据库实例密码时必须填写。

- [ ] 登录响应返回 `rpk`
- [ ] 前端 RSA 密文可被后端私钥解密
- [ ] 保存实例时密码以 AES 密文入库
- [ ] 更新实例时空密码沿用旧密码
- [ ] 更新实例时非空密码替换为新 AES 密文
- [ ] 测试连接时可正确解密并连接
- [ ] SQL 执行前可正确 AES 解密
- [ ] 接口响应不返回数据库密码
- [ ] 日志不打印 RSA 密文、AES 密文、数据库明文密码

验证说明：

```text
{说明使用的接口、数据、日志检查结果}
```

## 10. SSO / Auth Validation

涉及登录、SSO、JWT、权限上下文时必须填写。

- [ ] 本地账号密码登录成功
- [ ] 本地账号密码错误登录失败
- [ ] SSO code 换 token 成功
- [ ] SSO userinfo 获取成功
- [ ] `preferredUsername` 能匹配本地 `ziy_code`
- [ ] SSO 用户不存在时返回前端兼容的失败码和消息
- [ ] JWT 可用于访问受保护接口
- [ ] JWT 过期或非法时被拒绝
- [ ] 登录响应包含角色、业务线、`rpk`
- [ ] 日志不打印 access token、refresh token、id token、client_secret

验证说明：

```text
{说明 SSO 环境、Mock 方式或未验证原因}
```

## 11. Redis / MQ / ES Mapping / Config Validation

涉及异步任务、缓存、ES mapping / 索引模板 / alias、配置变更或状态流转时必须填写。

- [ ] 已核对 `config-change.md` 或确认不适用
- [ ] RocketMQ 消息生产成功
- [ ] RocketMQ 消息消费成功
- [ ] RabbitMQ exchange / queue / routing key 配置正确，或确认不适用
- [ ] ES mapping / 索引模板 / alias 配置正确，或确认不适用
- [ ] 消费失败重试行为符合预期
- [ ] Redis running task 写入和删除正确
- [ ] Redis stop flag 写入和删除正确
- [ ] Redis instance concurrency slot 获取和释放正确
- [ ] 重复消费不会造成错误状态

验证说明：

```text
{说明 Nacos 配置、topic、consumer group、RabbitMQ exchange / queue / routing key、Redis key、ES mapping / 索引模板 / alias、状态变化}
```

## 12. Security And Log Validation

- [ ] 日志不包含密码
- [ ] 日志不包含 Token
- [ ] 日志不包含密钥
- [ ] 异常信息不会暴露敏感连接串
- [ ] 新增接口鉴权策略明确
- [ ] 用户输入有校验

检查方式：

```bash
rg -n "password|token|secret|private-key|access_token|refresh_token" jzt-release-server/src/main/java jzt-release-infra/src/main/java
```

检查结论：

```text
{说明是否存在敏感日志，若存在必须列出处理计划}
```

## 13. Project Docs Validation

根据 `tasks.md` 的 Project Docs Impact 核对项目级事实源，只验证一致性，不在本阶段新增或修改项目级文档。

| 项目级文档 | tasks 判断 | 实际 diff | 结果 | 证据 / 未执行原因 |
| --- | --- | --- | --- | --- |
| `architecture.md` | 适用 / 不适用 | 有 / 无 | PASS / FAIL / N/A / NOT RUN | {说明} |
| `domain-map.md` | 适用 / 不适用 | 有 / 无 | PASS / FAIL / N/A / NOT RUN | {说明} |
| `glossary.md` | 适用 / 不适用 | 有 / 无 | PASS / FAIL / N/A / NOT RUN | {说明} |
| `constitution.md` | 适用 / 不适用 | 有 / 无 | PASS / FAIL / N/A / NOT RUN | {说明} |

必须确认：

- [ ] 适用的项目级文档已更新，且与代码、feature 文档和模块文档一致。
- [ ] 不适用的项目级文档已有明确原因。
- [ ] 未把普通 feature 流水账写入项目级事实源。
- [ ] 如果实际 diff 与 Project Docs Impact 不一致，已判定是否需要回退 `tasks.md`、`plan.md` 或 `spec.md`。

验证说明：

```text
{说明核对结论；如有 FAIL，说明应回退到 tasks、plan 还是 spec。}
```

## 14. Quality Attribute Validation

### 14.1 Minimal Impact Validation

- [ ] 未修改 `spec.md` / `plan.md` / `tasks.md` 之外的业务范围
- [ ] 未改变未声明的接口路径、请求字段、响应字段或错误码
- [ ] 未改变未声明的数据结构、配置项、Redis key、MQ topic、ES mapping
- [ ] 未改变未声明的状态流转、权限策略或兼容行为

验证说明：

```text
{说明 diff / 接口 / 配置 / 数据结构核对结果；如有未执行项说明原因。}
```

### 14.2 Robustness And Exception Boundary Validation

| 边界类型 | 结果 | 证据 / 未执行原因 |
| --- | --- | --- |
| 空值 / 缺失字段 | PASS / FAIL / N/A / NOT RUN | {说明} |
| 非法输入 / 非法状态 | PASS / FAIL / N/A / NOT RUN | {说明} |
| 外部依赖失败 / 超时 | PASS / FAIL / N/A / NOT RUN | {说明} |
| 并发 / 重复提交 / 重复消费 | PASS / FAIL / N/A / NOT RUN | {说明} |
| 部分成功 / 事务回滚 / 最终一致 | PASS / FAIL / N/A / NOT RUN | {说明} |
| 资源释放 / 连接关闭 / 临时状态清理 | PASS / FAIL / N/A / NOT RUN | {说明} |

### 14.3 Performance And Capacity Validation

- [ ] 批量规模 / 分页边界已验证或说明不适用
- [ ] 循环复杂度和远程调用次数已评估
- [ ] 文件大小 / 内存占用 / 流式处理边界已验证或说明不适用
- [ ] ES / Redis / MQ / DB 访问次数和索引命中已评估
- [ ] 未新增明显 N+1、无界循环、无界缓存或无超时外部调用

验证说明：

```text
{说明性能指标、容量边界、测试数据规模、命令、日志或未执行原因。}
```

### 14.4 Maintainability And Readability Validation

- [ ] 职责边界清晰，未把业务分支放入错误层级
- [ ] 命名能表达业务语义
- [ ] 重复逻辑可接受，或已通过合理抽象降低重复
- [ ] 关键业务规则、状态流转、异常边界、排序 / 解析 / 加密 / 并发等非显然逻辑已有简洁中文注释
- [ ] 注释说明原因和边界，不重复描述代码逐行行为

验证说明：

```text
{说明 review 结论、关键注释位置、未补充注释原因或后续处理计划。}
```

## 15. Regression Scope

本次需要回归的已有能力：

- [ ] 登录
- [ ] 菜单
- [ ] 角色权限
- [ ] 数据库实例管理
- [ ] 文件上传
- [ ] 发布任务
- [ ] SQL 执行
- [ ] 任务停止
- [ ] 执行记录查询

## 16. Final Conclusion

- [ ] 验证通过，可以合并
- [ ] 存在非阻塞问题，可以合并但需记录后续任务
- [ ] 存在阻塞问题，不能合并

遗留问题：

```text
{列出问题、风险、负责人、后续处理计划}
```
