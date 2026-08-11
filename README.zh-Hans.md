# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit 是一套可迁移的 AI 辅助开发工作流工具包。
它为编码 Agent 提供分阶段流程：

```text
sdd-bootstrap
sdd-use
sdd-spec
sdd-plan
sdd-tasks
sdd-apply
sdd-validate
sdd-archive
```

目标不是把某个项目的业务知识复制到另一个项目，而是复制工作流、阶段门禁、模板和 Agent 指令，再由目标项目通过 `sdd-bootstrap` 生成自己的项目事实源。

## 项目内容

```text
template/
  AGENTS.md
  docs/sdd/
    AGENTS.md
    workflow.md
    commands/
    templates/
    migration/

adapters/
  codex/
    skills/

scripts/
  install.sh
  check-sdd.sh
```

`template/` 包含工具无关的 SDD 规则和文档模板。
`adapters/codex/` 包含 Codex 短命令触发入口。
`template/docs/sdd/commands/` 中的命令规则是真实规则源。

## 快速开始

在目标项目中执行：

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

如果目标项目使用 Codex，并希望启用短命令触发：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

然后向 AI 编码 Agent 输入：

```text
sdd-bootstrap
```

Agent 应分析目标项目并生成：

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

开始 feature 开发前，请先人工 review 这些文件。

## 日常流程

```text
sdd-use user-export
sdd-spec
人工：将 spec.md 标记为 Confirmed
sdd-plan
人工：将 plan.md 标记为 Reviewed
sdd-tasks
人工：将 tasks.md 标记为 Approved
sdd-apply
sdd-validate
sdd-archive
```

## 关闭 spec.md 的 Open Questions

将 `spec.md` 标记为 `Confirmed` 之前，必须为 `Open Questions` 中的每个问题补充答案并关闭：

```md
- [x] Q: {待确认问题}
  A: {确认后的答案或决策}
```

只有所有 Open Questions 都已勾选并包含答案后，人工才能更新：

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

阶段门禁是强制设计：

- 没有 Confirmed `spec.md`，不得生成实现方案。
- 没有 Reviewed `plan.md`，不得拆解任务。
- 没有 Approved `tasks.md`，不得修改代码。
- 验证失败时不得归档。

## 阶段回滚

当已经人工通过的上游产物不再正确时，使用回滚命令。

```text
sdd-tasks rollback
{说明为什么 tasks.md 需要修改}

sdd-plan rollback
{说明为什么 plan.md 需要修改}

sdd-spec rollback
{说明为什么 spec.md 需要修改}
```

回滚规则：

- 任务遗漏或验证项不完整时，回滚 `tasks.md`；继续改代码前必须重新 Approved。
- 方案、影响范围或验证策略错误时，回滚 `plan.md`；`tasks.md` 也会重新打开。
- 需求、验收条件、业务规则、权限、数据口径或兼容性变化时，回滚 `spec.md`；`plan.md` 和 `tasks.md` 也会重新打开。
- 回滚后必须停止编码，直到重新打开的产物再次通过人工门禁。

## 已接入项目如何更新

如果业务项目已经安装过 SDD Dev Kit，而本 GitHub 仓库后续有更新，只更新通用流程文件：

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

如果目标项目使用 Codex：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

然后验证集成：

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

更新时不要覆盖项目事实源。目标项目自己的 `constitution.md`、`architecture.md`、`domain-map.md`、`glossary.md`、`modules/*` 和 `features/*` 应保留并按需 review。

## 不要从其他项目复制的内容

不要复制其他仓库中的项目专属 SDD 事实：

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

这些文件必须在每个目标项目中生成或 review。

## 验证

安装后在目标项目中运行：

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

检查脚本会验证可迁移工作流文件是否存在，并确认没有意外安装项目专属事实源。
