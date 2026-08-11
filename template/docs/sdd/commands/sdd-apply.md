# sdd-apply

基于已 Approved 的 `tasks.md` 修改代码。

## Input

```text
sdd-apply
```

## Preconditions

当前 feature 必须满足：

- `spec.md`: `Status: Confirmed`
- `plan.md`: `Status: Reviewed`
- `tasks.md`: `Status: Approved`
- `Approved By` 非空
- `Approved At` 非空

任一不满足，停止，不修改代码。

## Behavior

1. 读取 `AGENTS.md`、`docs/sdd/workflow.md`、`docs/sdd/commands/AGENTS.md`。
2. 读取 `spec.md`、`plan.md`、`tasks.md`。
3. 如果存在 `api-change.md`、`db-change.md`、`config-change.md`，必须读取并作为接口、数据库、配置变更依据。
4. 读取相关模块 `current.md` 和 `validate.md`。
5. 读取 `tasks.md` 的 Project Docs Impact。
6. 如果 Project Docs Impact 标记 `architecture.md`、`domain-map.md`、`glossary.md`、`constitution.md` 适用，必须按任务读取并更新对应项目级文档。
7. 严格按 `tasks.md` 修改代码。
8. 如果 `tasks.md` 包含自动化测试任务，在编码阶段新增或更新测试代码。
9. 按 `tasks.md` 的质量属性任务落实最小影响、异常边界、性能 / 容量、关键中文注释和可读性要求。
10. 更新 `tasks.md` 中任务完成状态。

## Stop Conditions

- 发现 `spec.md`、`plan.md` 或 `tasks.md` 需要变更。
- 发现 `api-change.md`、`db-change.md`、`config-change.md` 与实际需要不一致。
- 发现 Project Docs Impact 与实际代码或业务变化不一致。
- 发现需要新增、删除或修改未列入 `tasks.md` 的项目级文档更新。
- 发现 SDD 文档与代码冲突。
- 发现实现范围超出 `tasks.md`。
- 发现新的异常边界、性能 / 容量风险、扩展性要求或可维护性问题超出 `tasks.md`。

遇到以上情况必须停止，并提示执行对应回退命令。

## Forbidden

- 不做 `tasks.md` 之外的扩展需求。
- 不修改未列入 `tasks.md` 的接口、字段、状态、配置、数据结构或公共行为。
- 不省略关键业务规则、状态流转、异常边界、排序 / 解析 / 加密 / 并发等非显然逻辑的中文注释。
- 不在验证失败前更新模块 `current.md` 或 `history.md`。
- 不修改未在 Project Docs Impact 中标记适用且未列入任务的项目级文档。
- 已修改项目级文档后发现需要回退时，不静默撤销；按问题归属回退 `tasks.md`、`plan.md` 或 `spec.md`。

## Output

回复必须包含：

- 本命令完成了什么：按 `tasks.md` 实现代码。
- 修改的代码文件。
- 修改的测试文件。
- 修改的 SDD 文件。
- 修改的项目级文档。
- 已完成的 task。
- 是否发现需要回退的问题。
- 当前 feature 处于什么状态。
- 是否满足下一阶段门禁。
- 下一步应该执行什么命令：如果实现完成且无回退问题，执行 `sdd-validate`。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
- 如果执行了验证命令，列出命令和结果；如果未执行，说明原因。
