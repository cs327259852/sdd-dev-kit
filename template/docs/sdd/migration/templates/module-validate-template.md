# Module Validate: {module}

本文档记录 `{module}` 模块级验证要求。

它不记录某次 feature 的执行结果。feature 的实际验证结果应写入：

```text
docs/sdd/features/{date}-{feature}/validate.md
```

## 1. Validation Scope

| 验证类型 | 是否适用 | 说明 |
| --- | --- | --- |
| 编译 / 类型检查 | `{是 / 否}` | `{说明}` |
| 单元测试 | `{是 / 否}` | `{说明}` |
| 集成测试 | `{是 / 否}` | `{说明}` |
| API / 入口验证 | `{是 / 否}` | `{说明}` |
| 数据存储验证 | `{是 / 否}` | `{说明}` |
| 权限 / 安全验证 | `{是 / 否}` | `{说明}` |
| 外部依赖验证 | `{是 / 否}` | `{说明}` |
| 性能 / 容量验证 | `{是 / 否}` | `{说明}` |

## 2. Recommended Commands

```bash
{compile command}
{test command}
{module-specific command}
```

## 3. Standard Scenarios

| 场景 | 验证方式 | 预期结果 |
| --- | --- | --- |
| `{scenario}` | `{method}` | `{expected}` |

## 4. Exception Scenarios

| 场景 | 验证方式 | 预期结果 |
| --- | --- | --- |
| `{scenario}` | `{method}` | `{expected}` |

## 5. Security Checks

- [ ] 不输出敏感凭据。
- [ ] 权限不足场景已验证。
- [ ] 用户输入校验已验证。
- [ ] 日志脱敏已验证。

## 6. Final Result Format

模块验证结论统一使用：

```md
## Final Result

- [ ] 验证通过
- [ ] 验证不通过
- [ ] 部分验证未执行，原因已说明
```

## 7. Open Questions

- [ ] Q: `{待确认验证方式}`
