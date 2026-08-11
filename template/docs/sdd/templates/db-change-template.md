# DB Change: {Feature Name}

本文件记录当前 feature 的数据库变更，作为 `sdd-tasks` 阶段交付物。

不得记录数据库账号、密码、连接串或生产数据明细。

## 1. Summary

```text
{说明本次 DB 变更目标、影响表、兼容性和回滚结论。}
```

## 2. Change List

| Object | Change Type | Description | Compatibility |
| --- | --- | --- | --- |
| `{table / index / data}` | DDL / DML / Index / Data Fix | `{说明}` | Compatible / Breaking |

## 3. Execute SQL

执行顺序必须与本节顺序一致。

```sql
-- {说明}
{DDL 或 DML}
```

## 4. Compatibility

```text
{说明存量数据默认值、历史数据修复、灰度期间新旧代码兼容方式。}
```

## 5. Rollback SQL

```sql
-- {说明}
{回滚 SQL}
```

## 6. Validation

```text
{说明如何验证字段、索引、默认值、数据修复、回滚脚本。}
```

## 7. Risk Notes

- [ ] 已评估锁表、长事务或大表 DDL 风险。
- [ ] 已评估回滚是否会丢数据。
- [ ] 已评估 Mapper / Entity / XML 字段映射同步。
