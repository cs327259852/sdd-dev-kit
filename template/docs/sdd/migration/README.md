# SDD Migration Guide

本文档说明如何把 SDD Dev Kit 的开发范式迁移到目标项目。

迁移目标是复用流程、门禁、命令和模板，不复制来源项目的业务事实、技术栈专属规则或历史 feature。

## 1. 推荐迁移方式

1. 在目标项目中执行 SDD Dev Kit 的安装脚本，复制通用流程文件。
2. 在目标项目中打开 AI 工具，发送 `sdd-bootstrap`。
3. AI 基于目标项目代码、README、配置、数据库脚本、接口文档和测试生成项目级 SDD 初稿，包括 `AGENTS.md`、`constitution.md`、`domain-map.md`、`architecture.md`、`glossary.md` 和 `modules/*/current.md` 等文件。无法确认的内容必须写入 Open Questions。
4. 人工 review 上述文件。如果发现和代码实际不符，可以让 AI 或人工修改。修改后应通知 AI 复核项目级 SDD 事实源是否仍能支撑后续 feature 开发。
5. 确认完成后，再按 `sdd-use -> sdd-spec -> sdd-plan -> sdd-tasks -> sdd-apply -> sdd-validate -> sdd-archive` 开始 feature 开发。

## 2. 需要复制到新项目的文件

| 文件 / 目录 | 是否建议复制 | 说明 |
| --- | --- | --- |
| `AGENTS.md` | 条件复制 | 不要直接照搬完整内容。复制通用路由结构后，按新项目技术栈改写安全红线、代码修改门禁、测试命令和高风险区域。技术栈差异较大时，使用 `docs/sdd/migration/templates/root-agents-template.md` 生成。 |
| `docs/sdd/AGENTS.md` | 建议复制 | SDD 详细入口和事实源读取规则，可作为通用流程基础。复制后检查项目路径和高风险区域。 |
| `docs/sdd/workflow.md` | 建议复制 | SDD 阶段流程和人工门禁规则。 |
| `docs/sdd/commands/` | 建议复制 | 工具无关命令说明。 |
| `docs/sdd/templates/` | 建议复制 | feature 产物模板。 |
| `docs/sdd/migration/` | 建议复制 | 本迁移指导和新项目事实源模板。 |
| `.codex/skills/sdd-*` | 条件复制 | 仅当新项目也使用 Codex 并希望保留短命令触发时复制。复制后检查 skill 中引用路径是否一致。 |

## 3. 不要直接复制的文件

| 文件 / 目录 | 原因 |
| --- | --- |
| `docs/sdd/constitution.md` | 来源项目工程宪法，包含来源项目技术栈和安全规则。目标项目必须基于自己的事实生成。 |
| `docs/sdd/architecture.md` | 来源项目架构事实，不能代表目标项目架构。 |
| `docs/sdd/domain-map.md` | 来源项目业务域、模块和代码入口映射，必须重建。 |
| `docs/sdd/glossary.md` | 来源项目业务术语和状态口径，必须重建。 |
| `docs/sdd/modules/*` | 来源项目模块事实、验证要求和历史，不能迁移为目标项目事实。 |
| `docs/sdd/features/*` | 来源项目 feature 历史，不应作为目标项目需求历史。 |
| `.sdd/current-feature` | 本机当前 feature 指针，不是团队共享事实源。 |

## 4. 新项目 SDD 构建步骤

### Step 1: 放置通用流程文件

在新项目创建基础目录：

```text
docs/sdd/
  commands/
  templates/
  migration/
  modules/
  features/
```

复制通用流程文件后，先不要复制来源项目的项目级事实源。

### Step 2: 生成根 AGENTS.md

如果目标项目技术栈与来源项目类似，可以复用根 `AGENTS.md` 的通用路由结构，但必须改写项目专属规则。

如果技术栈差异较大，使用：

```text
docs/sdd/migration/templates/root-agents-template.md
```

生成新项目根 `AGENTS.md`。

必须按新项目事实填充：

- 认证 / 鉴权上下文。
- 数据库访问规范。
- 配置、缓存、消息、搜索、文件存储等高风险区域。
- 测试命令。
- 安全红线中的技术专属规则。

### Step 3: 执行 sdd-bootstrap

在新项目中使用：

```text
sdd-bootstrap
```

或自然语言：

```text
根据 docs/sdd/migration 初始化目标项目 SDD 规范
```

AI 应只读分析新项目，并按 `project-bootstrap-guide.md` 生成项目级 SDD 初稿。

### Step 4: 生成项目级事实源

使用以下模板生成：

- `docs/sdd/migration/templates/constitution-template.md`
- `docs/sdd/migration/templates/architecture-template.md`
- `docs/sdd/migration/templates/domain-map-template.md`
- `docs/sdd/migration/templates/glossary-template.md`

输出到：

```text
docs/sdd/constitution.md
docs/sdd/architecture.md
docs/sdd/domain-map.md
docs/sdd/glossary.md
```

### Step 5: 生成模块级事实源

使用以下模板生成：

- `docs/sdd/migration/templates/module-current-template.md`
- `docs/sdd/migration/templates/module-validate-template.md`
- `docs/sdd/migration/templates/module-history-template.md`

输出到：

```text
docs/sdd/modules/{module}/current.md
docs/sdd/modules/{module}/validate.md
docs/sdd/modules/{module}/history.md
```

### Step 6: 人工确认

人工 review 以下文件：

- 根 `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`

未确认前，不应把这些文件作为后续 feature 开发的最终事实源。

## 5. AI 生成约束

- 只能记录能从新项目代码、README、配置、数据库脚本、接口文档或测试确认的事实。
- 不能确认的内容必须写入 Open Questions。
- 不得编造业务规则、模块职责、状态流转或技术约束。
- 不得把来源项目的业务事实当成目标项目事实。
- 不得一次性读取无关大型文件、依赖目录、构建产物或二进制文件。

## 6. 敏感信息红线

迁移和 bootstrap 过程中不得记录、输出或提交：

- 密码
- Token
- 密钥
- RSA 私钥
- AES key
- 数据库账号、密码、连接串
- 生产请求凭据

发现敏感信息时，只记录“存在敏感配置来源或凭据管理机制”，不要写出具体值。
