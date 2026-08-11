# SDD Project Bootstrap Guide

本文档指导 AI 在新项目中基于迁移模板生成项目级 SDD 文件。

## 1. 适用场景

- 新项目首次引入 SDD。
- 从其他项目迁移 SDD 开发范式。
- 需要基于当前代码和文档生成项目事实源初稿。

不适用：

- 当前项目普通 feature 开发。
- 直接修改业务代码。
- 生成 `spec.md`、`plan.md`、`tasks.md` 等 feature 产物。

## 2. 输入来源

AI 应按以下顺序渐进读取：

1. 根目录说明：`README*`、`docs/` 中的项目说明。
2. 构建文件：如 `pom.xml`、`build.gradle`、`package.json`、`go.mod`、`Cargo.toml`、`pyproject.toml`。
3. 目录结构：识别应用入口、业务模块、测试目录、配置目录。
4. 配置文件示例：只记录配置项语义，不记录敏感值。
5. HTTP / RPC / CLI 入口：Controller、route、handler、command、resolver。
6. 业务层：Service、domain、application、usecase。
7. 数据访问层：Repository、Mapper、DAO、ORM schema、migration。
8. 异步和集成入口：job、listener、consumer、producer、scheduler。
9. 数据库脚本：DDL、migration、seed、fixture。
10. 测试代码：单元测试、集成测试、端到端测试。

不要读取：

- 依赖目录，如 `node_modules/`、`.gradle/`、`target/`、`build/`。
- 生成产物。
- 二进制文件。
- 大型日志或导出数据。
- 任何凭据明文。

## 3. 生成顺序

按以下顺序生成：

1. 根 `AGENTS.md`，可使用 `templates/root-agents-template.md`。
2. `docs/sdd/constitution.md`。
3. `docs/sdd/architecture.md`。
4. `docs/sdd/domain-map.md`。
5. `docs/sdd/glossary.md`。
6. `docs/sdd/modules/AGENTS.md`。
7. `docs/sdd/modules/{module}/current.md`。
8. `docs/sdd/modules/{module}/validate.md`。
9. `docs/sdd/modules/{module}/history.md`。

## 4. 事实约束

AI 只能写入可验证事实。

可验证事实包括：

- 代码中能定位的入口、类、函数、路由、配置读取点。
- README 或项目文档明确说明的业务目标和架构。
- migration / DDL 中明确存在的数据对象。
- 测试中体现的行为和边界。
- 配置样例中能确认的配置项名称和用途。

不能确认时：

```md
## Open Questions

- [ ] Q: {无法从当前项目事实确认的问题}
```

不得用猜测填充：

- 业务规则。
- 权限模型。
- 状态流转。
- 数据口径。
- 外部依赖语义。
- 性能和容量指标。

## 5. 模块识别规则

优先从以下证据识别模块：

- 顶层业务目录。
- Controller / route 分组。
- Service / usecase 分组。
- 数据表或聚合根。
- 明确的 bounded context。
- README 中的业务能力说明。

如果模块边界不清晰：

- 先生成候选模块。
- 在 `domain-map.md` 和相关模块文件中写入 Open Questions。
- 不强行合并或拆分模块。

## 6. 输出要求

每个生成文件应包含：

- 文件用途。
- 当前可确认事实。
- 维护规则。
- Open Questions。

生成完成后必须输出：

- 新增或更新的文件清单。
- 事实来源摘要。
- 未确认问题清单。
- 建议人工 review 顺序。
- 是否发现敏感信息；如发现，只说明类别，不输出具体值。

## 7. 人工 Review 要求

人工需要确认：

- 根 `AGENTS.md` 是否符合项目协作方式。
- `constitution.md` 是否准确表达工程红线。
- `architecture.md` 是否准确表达架构边界和关键链路。
- `domain-map.md` 是否准确表达业务域、模块和代码入口。
- `glossary.md` 是否统一关键术语和状态。
- 模块 `current.md` 是否反映当前真实行为。
- 模块 `validate.md` 是否可执行。
- 模块 `history.md` 是否只记录基线和后续 feature 时间线。

Open Questions 未关闭前，不应把对应内容作为后续 feature 开发的确定事实。
