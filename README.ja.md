# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit は、AI 支援ソフトウェア開発のための移植可能なワークフローキットです。
コーディング Agent に段階的なプロセスを提供します。

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

目的は、あるプロジェクトの業務知識を別のプロジェクトへコピーすることではありません。
ワークフロー、ゲート、テンプレート、Agent 向け指示をコピーし、対象プロジェクト自身の事実を `sdd-bootstrap` で生成することです。

## プロジェクトの内容

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

`template/` には、ツール非依存の SDD ルールとドキュメントテンプレートが含まれます。
`adapters/codex/` には、Codex の短縮コマンド用エントリポイントが含まれます。
`template/docs/sdd/commands/` のコマンドルールが真のルールソースです。

## クイックスタート

対象プロジェクトで実行します。

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

対象プロジェクトで Codex を使い、短縮コマンドを有効にしたい場合：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

次に AI コーディング Agent に入力します。

```text
sdd-bootstrap
```

Agent は対象プロジェクトを分析し、次のファイルを生成します。

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

feature 開発を始める前に、これらのファイルをレビューしてください。

## 日常ワークフロー

```text
sdd-use user-export
sdd-spec
human: spec.md を Confirmed にする
sdd-plan
human: plan.md を Reviewed にする
sdd-tasks
human: tasks.md を Approved にする
sdd-apply
sdd-validate
sdd-archive
```

## spec.md の Open Questions を閉じる

`spec.md` を `Confirmed` にする前に、`Open Questions` の各項目を回答付きで閉じる必要があります。

```md
- [x] Q: {質問}
  A: {確認済みの回答または決定}
```

すべての Open Questions にチェックが付き、回答が記載された後でのみ、人が次を更新できます。

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

ゲートは意図的に設けられています。

- Confirmed の `spec.md` がなければ、実装計画を作らない。
- Reviewed の `plan.md` がなければ、タスク分解をしない。
- Approved の `tasks.md` がなければ、コードを変更しない。
- 検証失敗時はアーカイブしない。

## ステージのロールバック

レビュー済みの上流成果物が正しくなくなった場合は rollback を使います。

```text
sdd-tasks rollback
{tasks.md を変更する理由}

sdd-plan rollback
{plan.md を変更する理由}

sdd-spec rollback
{spec.md を変更する理由}
```

ロールバック規則：

- タスク漏れや検証不足がある場合は `tasks.md` をロールバックします。コード変更を続ける前に再度 Approved が必要です。
- 設計、影響範囲、検証戦略が誤っている場合は `plan.md` をロールバックします。`tasks.md` も再オープンされます。
- 要件、受け入れ条件、業務ルール、権限、データの意味、互換性が変わった場合は `spec.md` をロールバックします。`plan.md` と `tasks.md` も再オープンされます。
- ロールバック後は、再オープンされた成果物が人によるゲートを再通過するまでコーディングを停止します。

## 既存導入プロジェクトの更新

すでに SDD Dev Kit を導入済みのプロジェクトで、この GitHub リポジトリに更新が入った場合は、移植可能なワークフローファイルだけを更新します。

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

対象プロジェクトで Codex を使う場合：

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

次に統合を検証します。

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

更新時にプロジェクト固有の事実を上書きしないでください。対象プロジェクト自身の `constitution.md`、`architecture.md`、`domain-map.md`、`glossary.md`、`modules/*`、`features/*` は保持し、必要に応じてレビューします。

## 他プロジェクトからコピーしてはいけないもの

他リポジトリ固有の SDD 事実をコピーしないでください。

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

これらのファイルは、対象プロジェクトごとに生成またはレビューする必要があります。

## 検証

インストール後、対象プロジェクトで実行します。

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

チェッカーは、移植可能なワークフローファイルが存在し、プロジェクト固有の事実が誤ってインストールされていないことを確認します。
