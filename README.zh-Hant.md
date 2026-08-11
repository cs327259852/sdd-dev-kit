# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit 是一套可遷移的 AI 輔助開發工作流工具包。
它為編碼 Agent 提供分階段流程：

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

目標不是把某個專案的業務知識複製到另一個專案，而是複製工作流、階段門禁、模板和 Agent 指令，再由目標專案透過 `sdd-bootstrap` 生成自己的專案事實來源。

## 專案內容

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

`template/` 包含工具無關的 SDD 規則和文件模板。
`adapters/codex/` 包含 Codex 短命令觸發入口。
`template/docs/sdd/commands/` 中的命令規則是真實規則來源。

## 快速開始

在目標專案中執行：

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

如果目標專案使用 Codex，並希望啟用短命令觸發：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

然後向 AI 編碼 Agent 輸入：

```text
sdd-bootstrap
```

Agent 應分析目標專案並生成：

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

開始 feature 開發前，請先人工 review 這些文件。

## 日常流程

```text
sdd-use user-export
sdd-spec
人工：將 spec.md 標記為 Confirmed
sdd-plan
人工：將 plan.md 標記為 Reviewed
sdd-tasks
人工：將 tasks.md 標記為 Approved
sdd-apply
sdd-validate
sdd-archive
```

## 關閉 spec.md 的 Open Questions

將 `spec.md` 標記為 `Confirmed` 之前，必須為 `Open Questions` 中的每個問題補充答案並關閉：

```md
- [x] Q: {待確認問題}
  A: {確認後的答案或決策}
```

只有所有 Open Questions 都已勾選並包含答案後，人工才能更新：

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

階段門禁是強制設計：

- 沒有 Confirmed `spec.md`，不得生成實作方案。
- 沒有 Reviewed `plan.md`，不得拆解任務。
- 沒有 Approved `tasks.md`，不得修改程式碼。
- 驗證失敗時不得歸檔。

## 階段回滾

當已經人工通過的上游產物不再正確時，使用回滾命令。

```text
sdd-tasks rollback
{說明為什麼 tasks.md 需要修改}

sdd-plan rollback
{說明為什麼 plan.md 需要修改}

sdd-spec rollback
{說明為什麼 spec.md 需要修改}
```

回滾規則：

- 任務遺漏或驗證項不完整時，回滾 `tasks.md`；繼續改程式碼前必須重新 Approved。
- 方案、影響範圍或驗證策略錯誤時，回滾 `plan.md`；`tasks.md` 也會重新打開。
- 需求、驗收條件、業務規則、權限、資料口徑或相容性變化時，回滾 `spec.md`；`plan.md` 和 `tasks.md` 也會重新打開。
- 回滾後必須停止編碼，直到重新打開的產物再次通過人工門禁。

## 已接入專案如何更新

如果業務專案已經安裝過 SDD Dev Kit，而本 GitHub 倉庫後續有更新，只更新通用流程文件：

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

如果目標專案使用 Codex：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

然後驗證整合：

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

更新時不要覆蓋專案事實來源。目標專案自己的 `constitution.md`、`architecture.md`、`domain-map.md`、`glossary.md`、`modules/*` 和 `features/*` 應保留並按需 review。

## 不要從其他專案複製的內容

不要複製其他倉庫中的專案專屬 SDD 事實：

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

這些文件必須在每個目標專案中生成或 review。

## 驗證

安裝後在目標專案中執行：

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

檢查腳本會驗證可遷移工作流文件是否存在，並確認沒有意外安裝專案專屬事實來源。
