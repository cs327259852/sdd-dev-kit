# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit est une boîte à outils portable pour le développement logiciel assisté par l'IA.
Elle donne aux agents de codage un processus par étapes :

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

Le but n'est pas de copier la connaissance métier d'un projet vers un autre.
Le but est de copier le workflow, les garde-fous, les modèles et les instructions d'agent, puis de laisser le projet cible générer ses propres faits avec `sdd-bootstrap`.

## Contenu du projet

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

`template/` contient les règles SDD indépendantes des outils et les modèles de documents.
`adapters/codex/` contient les points d'entrée Codex pour les commandes courtes.
Les règles dans `template/docs/sdd/commands/` sont la source de vérité.

## Démarrage rapide

Depuis un projet cible :

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

Si le projet cible utilise Codex et que vous voulez activer les commandes courtes :

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

Demandez ensuite à votre agent de codage IA :

```text
sdd-bootstrap
```

L'agent doit analyser le projet cible et générer :

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

Relisez ces fichiers avant de commencer le développement de fonctionnalités.

## Workflow quotidien

```text
sdd-use user-export
sdd-spec
humain : marquer spec.md comme Confirmed
sdd-plan
humain : marquer plan.md comme Reviewed
sdd-tasks
humain : marquer tasks.md comme Approved
sdd-apply
sdd-validate
sdd-archive
```

## Fermer les Open Questions de spec.md

Avant de marquer `spec.md` comme `Confirmed`, chaque élément de `Open Questions` doit être fermé avec une réponse :

```md
- [x] Q: {question}
  A: {réponse ou décision confirmée}
```

Une fois seulement que toutes les Open Questions sont cochées et répondues, un humain peut mettre à jour :

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

Les garde-fous sont intentionnels :

- Pas de `spec.md` Confirmed, pas de plan d'implémentation.
- Pas de `plan.md` Reviewed, pas de découpage en tâches.
- Pas de `tasks.md` Approved, pas de modification du code.
- Une validation échouée bloque l'archivage.

## Ce qu'il ne faut pas copier depuis un autre projet

Ne copiez pas les faits SDD propres à un autre dépôt :

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

Ces fichiers doivent être générés ou relus pour chaque projet cible.

## Vérification

Après l'installation, exécutez ceci depuis le projet cible :

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

Le vérificateur confirme que les fichiers portables du workflow existent et qu'aucun fait propre à un projet n'a été installé par erreur.
