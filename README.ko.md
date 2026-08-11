# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit은 AI 지원 소프트웨어 개발을 위한 이식 가능한 워크플로우 키트입니다.
코딩 Agent에게 단계별 프로세스를 제공합니다.

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

목표는 한 프로젝트의 비즈니스 지식을 다른 프로젝트로 복사하는 것이 아닙니다.
목표는 워크플로우, 게이트, 템플릿, Agent 지침을 복사한 뒤 대상 프로젝트가 `sdd-bootstrap`으로 자체 프로젝트 사실을 생성하게 하는 것입니다.

## 프로젝트 구성

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

`template/`에는 도구 중립적인 SDD 규칙과 문서 템플릿이 들어 있습니다.
`adapters/codex/`에는 Codex 짧은 명령 진입점이 들어 있습니다.
`template/docs/sdd/commands/`의 명령 규칙이 기준 규칙입니다.

## 빠른 시작

대상 프로젝트에서 실행합니다.

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

대상 프로젝트에서 Codex를 사용하고 짧은 명령 트리거를 원한다면:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

그다음 AI 코딩 Agent에게 입력합니다.

```text
sdd-bootstrap
```

Agent는 대상 프로젝트를 분석하고 다음 파일을 생성해야 합니다.

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

feature 개발을 시작하기 전에 이 파일들을 검토하세요.

## 일상 워크플로우

```text
sdd-use user-export
sdd-spec
human: spec.md를 Confirmed로 표시
sdd-plan
human: plan.md를 Reviewed로 표시
sdd-tasks
human: tasks.md를 Approved로 표시
sdd-apply
sdd-validate
sdd-archive
```

## spec.md의 Open Questions 닫기

`spec.md`를 `Confirmed`로 표시하기 전에 `Open Questions`의 모든 항목을 답변과 함께 닫아야 합니다.

```md
- [x] Q: {질문}
  A: {확정된 답변 또는 결정}
```

모든 Open Questions가 체크되고 답변이 작성된 후에만 사람이 다음 내용을 업데이트해야 합니다.

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

게이트는 의도적으로 설계되었습니다.

- Confirmed `spec.md`가 없으면 구현 계획을 만들 수 없습니다.
- Reviewed `plan.md`가 없으면 작업을 분해할 수 없습니다.
- Approved `tasks.md`가 없으면 코드를 변경할 수 없습니다.
- 검증 실패는 아카이브를 막습니다.

## 단계 롤백

이미 검토된 상위 산출물이 더 이상 올바르지 않을 때 rollback을 사용합니다.

```text
sdd-tasks rollback
{tasks.md를 변경해야 하는 이유}

sdd-plan rollback
{plan.md를 변경해야 하는 이유}

sdd-spec rollback
{spec.md를 변경해야 하는 이유}
```

롤백 규칙:

- 작업이 누락되었거나 검증 항목이 불완전하면 `tasks.md`를 롤백합니다. 코드 변경을 계속하기 전에 다시 Approved가 필요합니다.
- 설계, 영향 범위 또는 검증 전략이 잘못되었으면 `plan.md`를 롤백합니다. `tasks.md`도 다시 열립니다.
- 요구사항, 인수 조건, 비즈니스 규칙, 권한, 데이터 의미 또는 호환성이 바뀌면 `spec.md`를 롤백합니다. `plan.md`와 `tasks.md`도 다시 열립니다.
- 롤백 후에는 다시 열린 산출물이 사람의 게이트를 다시 통과할 때까지 코딩을 중지합니다.

## 기존 도입 프로젝트 업데이트

이미 SDD Dev Kit을 설치한 프로젝트에서 이 GitHub 저장소가 업데이트되면, 이식 가능한 워크플로우 파일만 업데이트합니다.

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

대상 프로젝트가 Codex를 사용한다면:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

그다음 통합을 검증합니다.

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

업데이트 중 프로젝트 사실을 덮어쓰지 마세요. 대상 프로젝트 고유의 `constitution.md`, `architecture.md`, `domain-map.md`, `glossary.md`, `modules/*`, `features/*`는 유지하고 필요에 따라 검토해야 합니다.

## 다른 프로젝트에서 복사하면 안 되는 것

다른 저장소의 프로젝트 전용 SDD 사실을 복사하지 마세요.

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

이 파일들은 각 대상 프로젝트에서 생성하거나 검토해야 합니다.

## 검증

설치 후 대상 프로젝트에서 실행합니다.

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

검사 스크립트는 이식 가능한 워크플로우 파일이 존재하는지, 프로젝트 전용 사실이 실수로 설치되지 않았는지 확인합니다.
