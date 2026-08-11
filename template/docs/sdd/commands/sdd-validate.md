# sdd-validate

执行 SDD 验证，只更新当前 feature 的 `validate.md`。

## Input

```text
sdd-validate
```

## Preconditions

当前 feature 必须存在：

- `spec.md`
- `plan.md`
- `tasks.md`

并确认：

- `spec.md`: `Status: Confirmed`
- `plan.md`: `Status: Reviewed`
- `tasks.md`: `Status: Approved`

任一不满足，停止。

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `spec.md` 的 Acceptance Criteria 和 Success Metrics。
3. 读取 `plan.md` 的 Validation Plan。
4. 读取 `tasks.md` 的 Validation Tasks。
5. 如果存在 `api-change.md`、`db-change.md`、`config-change.md`，读取并核对接口、数据库、配置变更验证项。
6. 读取 `tasks.md` 的 Project Docs Impact，并核对适用的 `architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md` 是否已更新且与代码、feature 文档和模块文档一致。
7. 读取相关模块 `validate.md`。
8. 执行适用的编译、测试、接口验证、专项验证。
9. 使用 `docs/sdd/templates/validate-template.md` 创建或更新当前 feature 的 `validate.md`。
10. 验证最小影响、异常边界、性能 / 容量、关键中文注释、可读性、安全日志等质量属性；不涉及或未执行时说明原因。
11. 记录 PASS / FAIL / NOT RUN、证据、失败原因、未执行原因。

## Failure Handling

验证失败时：

- 必须停止。
- 不得更新模块 `current.md`。
- 不得更新模块 `history.md`。
- 判断失败原因属于代码、tasks、plan 还是 spec。
- 如果 Project Docs Impact 与实际变更不一致，按原因判断回退到 `tasks.md`、`plan.md` 或 `spec.md`。
- 提醒用户修代码或执行对应回退命令。

## Output

回复必须包含：

- 本命令完成了什么：执行验证并更新 feature `validate.md`。
- 修改了哪些文件。
- 执行的验证命令。
- 验证结果。
- 更新的 `validate.md`。
- 是否存在阻塞性 FAIL。
- 项目级文档一致性验证结果。
- 当前 feature 处于什么状态。
- 是否满足下一阶段门禁。
- 下一步应该执行什么命令：验证通过则执行 `sdd-archive`；验证失败则修代码或执行对应回退命令。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
- 如果有验证未执行，说明原因。
