# sdd-bootstrap

在新项目中根据迁移指导构建 SDD 开发范式。

本命令用于项目初始化，不用于当前项目普通 feature 开发，不绕过 `spec -> plan -> tasks -> apply` 阶段门禁。

## Input

推荐短命令：

```text
sdd-bootstrap
```

也支持：

```text
sdd-bootstrap from docs/sdd/migration
根据 docs/sdd/migration 初始化目标项目 SDD 规范
```

## Preconditions

新项目中应已复制或准备好：

- 根 `AGENTS.md` 模板或 `docs/sdd/migration/templates/root-agents-template.md`
- `docs/sdd/AGENTS.md`
- `docs/sdd/workflow.md`
- `docs/sdd/commands/`
- `docs/sdd/templates/`
- `docs/sdd/migration/`

如果上述文件缺失，先根据 `docs/sdd/migration/README.md` 补齐迁移文件。

## Behavior

1. 读取 `docs/sdd/migration/README.md`。
2. 读取 `docs/sdd/migration/project-bootstrap-guide.md`。
3. 读取 `docs/sdd/migration/templates/*` 中与生成目标相关的模板。
4. 只读分析新项目：
   - README / docs
   - 构建文件和依赖声明
   - 目录结构
   - 配置文件示例
   - Controller / route / handler / entrypoint
   - Service / domain / application 层
   - Repository / Mapper / DAO / ORM schema
   - 数据库 migration / DDL / seed
   - 测试代码
5. 生成或更新项目级 SDD 初稿：
   - 根 `AGENTS.md`
   - `docs/sdd/constitution.md`
   - `docs/sdd/architecture.md`
   - `docs/sdd/domain-map.md`
   - `docs/sdd/glossary.md`
   - `docs/sdd/modules/AGENTS.md`
   - `docs/sdd/modules/{module}/current.md`
   - `docs/sdd/modules/{module}/validate.md`
   - `docs/sdd/modules/{module}/history.md`
6. 对无法确认的问题写入 Open Questions。
7. 不修改业务代码。
8. 不生成 feature `spec.md`、`plan.md`、`tasks.md`、`validate.md`。

## Forbidden

- 不编造业务规则、状态流转、模块职责或技术约束。
- 不复制其他项目的项目事实源作为新项目事实。
- 不记录、输出或提交密码、Token、密钥、私钥、数据库凭证或生产请求凭据。
- 不读取无关大型文件、依赖目录、构建产物或二进制文件。
- 不修改业务代码、配置或数据库脚本。
- 不把生成的 Draft 事实源视为已人工确认。

## Output

回复必须包含：

- 本命令完成了什么。
- 新增或更新了哪些 SDD 文件。
- 新增或更新了哪些非 SDD 文件，例如根 `AGENTS.md`。
- 读取了哪些事实来源。
- 哪些内容写入了 Open Questions。
- 是否发现敏感信息；如发现，只说明类别，不输出具体值。
- 哪些文件需要人工 review。
- 下一步建议：人工 review 项目级事实源，确认后再执行 `sdd-use {feature}` 开始 feature 开发。

## Review Gate

`sdd-bootstrap` 生成的是项目级 SDD 初稿。人工 review 前，不应把其中的业务规则、模块职责、架构判断或安全红线作为最终事实。
