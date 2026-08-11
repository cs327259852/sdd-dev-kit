# SDD Commands

本目录是工具无关的 SDD 命令说明书。

Codex、Claude、Cursor、Copilot 或其他 Agent 都应优先读取这里的命令说明，而不是读取某个工具私有目录下的实现细节。

## Command List

| Command | Purpose |
| --- | --- |
| `sdd-bootstrap` | 在新项目中根据迁移指导构建 SDD 开发范式 |
| `sdd-help` | 查看 SDD 命令说明和使用示例 |
| `sdd-use {feature}` | 选择或创建当前 feature 目录 |
| `sdd-status` | 查看当前 feature 阶段状态 |
| `sdd-spec` | 在当前 feature 下生成 Draft `spec.md` |
| `sdd-plan` | 基于 Confirmed `spec.md` 生成 Draft `plan.md` |
| `sdd-tasks` | 基于 Reviewed `plan.md` 生成 Draft `tasks.md`，按影响范围生成 tasks 阶段交付物，并声明项目级文档影响 |
| `sdd-apply` | 基于 Approved `tasks.md` 修改代码，并按任务更新适用的项目级文档 |
| `sdd-validate` | 执行验证，只更新 feature `validate.md`，并核对项目级文档一致性 |
| `sdd-archive` | 验证通过后更新模块 `current.md` 和 `history.md` |

## Required Reading

执行任何命令前，Agent 必须读取：

1. `AGENTS.md`
2. `docs/sdd/AGENTS.md`
3. `docs/sdd/workflow.md`
4. 当前命令对应的 `docs/sdd/commands/{command}.md`

涉及业务实现时，还必须读取：

1. `docs/sdd/constitution.md`
2. `docs/sdd/architecture.md`
3. `docs/sdd/domain-map.md`
4. `docs/sdd/glossary.md`
5. `docs/sdd/modules/AGENTS.md`
6. 相关模块的 `current.md`、`validate.md`、`history.md`
7. 当前 feature 的 `spec.md`、`plan.md`、`tasks.md`

生成 SDD 产物时，还必须读取：

1. `docs/sdd/templates/AGENTS.md`
2. 对应产物模板，例如 `docs/sdd/templates/spec-template.md`
3. `sdd-tasks` 涉及条件性交付物时，还必须读取 `api-change-template.md`、`db-change-template.md`、`config-change-template.md`

## Feature Context

当前 feature 按以下顺序解析：

1. 用户本次输入明确指定 feature、feature 目录名或 feature 路径。
2. 读取 `.sdd/current-feature`。
3. 如果 `.sdd/current-feature` 不存在，但旧路径 `.codex/sdd-current-feature` 存在，可以读取旧路径并迁移写入 `.sdd/current-feature`。
4. 扫描 `docs/sdd/features/` 中唯一可判断为进行中的 feature。
5. 若不存在或存在多个候选，停止并要求用户先执行 `sdd-use {feature}`。

`.sdd/current-feature` 是本机上下文文件，可被其他 Agent 复用；它不是团队共享事实源。

## Hard Gates

- 没有 Confirmed `spec.md`，不得生成正式 `plan.md`。
- 没有 Reviewed `plan.md`，不得生成正式 `tasks.md` 或 tasks 阶段交付物。
- 没有 Approved `tasks.md`，不得修改业务代码。
- 验证失败时不得执行 `sdd-archive`。
- Agent 不得自行把 `spec.md` 改为 `Confirmed`。
- Agent 不得自行把 `plan.md` 改为 `Reviewed`。
- Agent 不得自行把 `tasks.md` 改为 `Approved`。
- 如果 SDD 文档与代码冲突，必须停止并报告冲突点。

## Output Contract

每个命令执行结束后，Agent 必须明确说明：

- 本命令完成了什么。
- 修改了哪些文件；如果没有修改文件，说明未修改。
- 当前 feature 处于什么状态。
- 是否满足下一阶段门禁。
- 下一步应该执行什么命令。
- 如果不能进入下一步，说明阻塞原因和需要人工完成的动作。
- 如果执行了验证命令，列出命令和结果；如果未执行，说明原因。

推荐下一步：

| Command | Success Next Step |
| --- | --- |
| `sdd-bootstrap` | 人工 review 生成的项目级 SDD 文件，确认后执行 `sdd-use {feature}` 开始 feature 开发 |
| `sdd-help` | 根据说明选择要执行的 SDD 命令 |
| `sdd-use` | 没有 `spec.md` 时执行 `sdd-spec`；否则执行 `sdd-status` 或当前缺失阶段 |
| `sdd-status` | 按当前阻塞门禁提示下一条命令或人工动作 |
| `sdd-spec` | 人工 review `spec.md`，改为 `Confirmed`，再执行 `sdd-plan` |
| `sdd-plan` | 人工 review `plan.md`，改为 `Reviewed`，再执行 `sdd-tasks` |
| `sdd-tasks` | 人工 review `tasks.md` 和适用的 `api-change.md`、`db-change.md`、`config-change.md`，将 `tasks.md` 改为 `Approved`，再执行 `sdd-apply` |
| `sdd-apply` | 执行 `sdd-validate` |
| `sdd-validate` | 通过则执行 `sdd-archive`；失败则修代码或执行对应回退命令 |
| `sdd-archive` | feature 完成，可提交、合并或发布 |
