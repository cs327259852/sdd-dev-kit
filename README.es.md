# SDD Dev Kit

[English](README.en.md) | [Français](README.fr.md) | [Español](README.es.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

SDD Dev Kit es un kit de flujo de trabajo portable para desarrollo de software asistido por IA.
Proporciona a los agentes de programación un proceso por etapas:

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

El objetivo no es copiar el conocimiento de negocio de un proyecto a otro.
El objetivo es copiar el flujo de trabajo, las puertas de control, las plantillas y las instrucciones para agentes, y dejar que el proyecto destino genere sus propios hechos con `sdd-bootstrap`.

## Contenido del proyecto

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

`template/` contiene reglas SDD independientes de la herramienta y plantillas de documentos.
`adapters/codex/` contiene puntos de entrada de Codex para comandos cortos.
Las reglas en `template/docs/sdd/commands/` son la fuente de verdad.

## Inicio rápido

Desde un proyecto destino:

```bash
git clone https://github.com/cs327259852/sdd-dev-kit.git ~/my_github/sdd-dev-kit
cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh
```

Si el proyecto destino usa Codex y quieres activar comandos cortos:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --codex
```

Luego pide a tu agente de codificación con IA:

```text
sdd-bootstrap
```

El agente debe analizar el proyecto destino y generar:

- `AGENTS.md`
- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*/current.md`
- `docs/sdd/modules/*/validate.md`
- `docs/sdd/modules/*/history.md`

Revisa esos archivos antes de empezar el desarrollo de features.

## Flujo diario

```text
sdd-use user-export
sdd-spec
humano: marcar spec.md como Confirmed
sdd-plan
humano: marcar plan.md como Reviewed
sdd-tasks
humano: marcar tasks.md como Approved
sdd-apply
sdd-validate
sdd-archive
```

## Cerrar las Open Questions de spec.md

Antes de marcar `spec.md` como `Confirmed`, cada elemento de `Open Questions` debe cerrarse con una respuesta:

```md
- [x] Q: {pregunta}
  A: {respuesta o decisión confirmada}
```

Solo después de que todas las Open Questions estén marcadas y respondidas, una persona debe actualizar:

```md
## 0. Confirmation

- Status: Confirmed
- Confirmed By: {name}
- Confirmed At: {yyyy-mm-dd}
```

Las puertas de control son intencionales:

- Sin `spec.md` Confirmed, no hay plan de implementación.
- Sin `plan.md` Reviewed, no hay desglose de tareas.
- Sin `tasks.md` Approved, no hay cambios de código.
- Una validación fallida bloquea el archivado.

## Rollback de etapa

Usa rollback cuando un artefacto ascendente ya revisado deja de ser correcto.

```text
sdd-tasks rollback
{por qué debe cambiar tasks.md}

sdd-plan rollback
{por qué debe cambiar plan.md}

sdd-spec rollback
{por qué debe cambiar spec.md}
```

Reglas de rollback:

- Si faltan tareas o la validación está incompleta, revierte `tasks.md`; debe aprobarse de nuevo antes de continuar con cambios de código.
- Si el diseño, el alcance de impacto o la estrategia de validación es incorrecta, revierte `plan.md`; `tasks.md` también se reabre.
- Si cambian requisitos, criterios de aceptación, reglas de negocio, permisos, significado de datos o compatibilidad, revierte `spec.md`; `plan.md` y `tasks.md` también se reabren.
- Después de un rollback, detén la codificación hasta que los artefactos reabiertos vuelvan a pasar las puertas humanas.

## Actualizar un proyecto existente

Si un proyecto ya instaló SDD Dev Kit y este repositorio de GitHub recibe actualizaciones, actualiza solo los archivos portables del workflow:

```bash
cd ~/my_github/sdd-dev-kit
git pull

cd /path/to/your-project
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force
```

Si el proyecto destino usa Codex:

```bash
bash ~/my_github/sdd-dev-kit/scripts/install.sh --force --codex
```

Luego verifica la integración:

```bash
bash ~/my_github/sdd-dev-kit/scripts/check-sdd.sh
```

No sobrescribas hechos del proyecto durante una actualización. Conserva y revisa los archivos propios del proyecto destino: `constitution.md`, `architecture.md`, `domain-map.md`, `glossary.md`, `modules/*` y `features/*`.

## Qué no copiar desde otro proyecto

No copies hechos SDD específicos de otro repositorio:

- `docs/sdd/constitution.md`
- `docs/sdd/architecture.md`
- `docs/sdd/domain-map.md`
- `docs/sdd/glossary.md`
- `docs/sdd/modules/*`
- `docs/sdd/features/*`
- `.sdd/current-feature`

Estos archivos deben generarse o revisarse para cada proyecto destino.

## Verificación

Después de instalar, ejecuta esto desde el proyecto destino:

```bash
bash /path/to/sdd-dev-kit/scripts/check-sdd.sh
```

El verificador confirma que existen los archivos portables del workflow y que no se instalaron por error hechos específicos de otro proyecto.
