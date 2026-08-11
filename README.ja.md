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

ゲートは意図的に設けられています。

- Confirmed の `spec.md` がなければ、実装計画を作らない。
- Reviewed の `plan.md` がなければ、タスク分解をしない。
- Approved の `tasks.md` がなければ、コードを変更しない。
- 検証失敗時はアーカイブしない。

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

