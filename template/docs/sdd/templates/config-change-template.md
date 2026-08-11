# Config Change: {Feature Name}

本文件记录当前 feature 的配置变更，作为 `sdd-tasks` 阶段交付物。

不得记录密码、Token、密钥、RSA 私钥、AES key、数据库凭证或生产连接串。

## 1. Summary

```text
{说明本次配置变更目标、配置来源、影响环境和回滚结论。}
```

## 2. Change List

| Type | Name / Key / Topic | Change Type | Scope | Default / Value Rule | Comment |
| --- | --- | --- | --- | --- | --- |
| Nacos / Redis / RocketMQ / RabbitMQ / ES Mapping / Env / JVM / Other | `{名称}` | Added / Modified / Removed | dev / test / prod / all | `{默认值或取值规则，不写敏感值}` | `{例如：Nacos 修改、Redis key 修改、RocketMQ topic 增加、RabbitMQ exchange / queue / routing key 增加、ES mapping 修改}` |

## 3. Nacos Changes

| Data ID / Group | Config Key | Change Type | Default / Value Rule | Related Class |
| --- | --- | --- | --- | --- |
| `{dataId}` / `{group}` | `{key}` | Added / Modified / Removed | `{默认值或取值规则}` | `{配置类或读取点}` |

说明：

```text
{说明新增配置类、配置项含义、是否需要刷新、是否影响启动。无 Nacos 变更时写“不适用”。}
```

## 4. Redis Changes

| Key / Pattern | Change Type | TTL | Producer / Consumer | Description |
| --- | --- | --- | --- | --- |
| `{key}` | Added / Modified / Removed | `{TTL}` | `{读写入口}` | `{说明}` |

说明：

```text
{说明 Redis key 语义、兼容策略和清理策略。无 Redis 变更时写“不适用”。}
```

## 5. MQ Changes

| MQ | Topic / Exchange / Queue / Routing Key | Change Type | Producer | Consumer | Description |
| --- | --- | --- | --- | --- | --- |
| RocketMQ / RabbitMQ | `{名称}` | Added / Modified / Removed | `{生产者}` | `{消费者}` | `{说明}` |

说明：

```text
{说明 RocketMQ topic、RabbitMQ exchange / queue / routing key 等变更，以及重复消费、订阅和回滚影响。无 MQ 变更时写“不适用”。}
```

## 6. ES Mapping / Index Changes

| ES Object | Index / Alias / Template | Change Type | Field / Setting | Compatibility | Description |
| --- | --- | --- | --- | --- | --- |
| Mapping / Index Template / Alias / Setting | `{名称}` | Added / Modified / Removed | `{字段或配置}` | Compatible / Breaking | `{说明}` |

说明：

```text
{说明 ES mapping、索引模板、alias、setting 的变更内容、是否需要重建索引、是否需要 reindex、存量数据兼容和回滚方式。无 ES 配置变更时写“不适用”。}
```

## 7. Other Config Changes

| Type | Name | Change Type | Default / Value Rule | Description |
| --- | --- | --- | --- | --- |
| Env / JVM / File / Other | `{名称}` | Added / Modified / Removed | `{默认值或取值规则}` | `{说明}` |

## 8. Rollback

```text
{说明如何回滚配置、是否需要重启、是否需要清理 Redis key、MQ 订阅、ES mapping / index template / alias。}
```

## 9. Validation

```text
{说明如何验证配置加载、默认值、环境隔离、Redis / MQ / ES 行为、ES mapping / index template / alias 和回滚。}
```
