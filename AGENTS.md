# AI Development Rules

This repository is a Godot 4.x project for a small 2D top-down action RPG. The project is also an experiment in disciplined AI-assisted game development.

## Product scope

The first playable version is intentionally small:

- One player
- One weapon
- One normal enemy
- One boss
- One dungeon
- Health, gold, and one health potion
- A health bar and gold counter
- Game-over and victory states

Do not add quests, crafting, procedural generation, multiplayer, skill trees, shops, an open world, or advanced NPC AI unless the game design is explicitly revised.

## Architecture

- Use Godot 4.x and typed GDScript.
- Prefer composition over deep inheritance hierarchies.
- Keep components small and focused on one responsibility.
- Prefer signals for communication between independent systems.
- Keep configuration and balancing data separate from behavior where practical, using Godot Resources.
- Avoid unnecessary Autoloads. A new global system requires an explicit architecture decision.
- Keep UI observing gameplay state; UI should not reach into gameplay internals to mutate them.
- Keep feature boundaries clear. One feature should not directly manipulate another feature's internal state.

## Development workflow

Follow the project adaptation of the Explainable Engineering Method in `docs/ENGINEERING_METHOD.md`. Keep work proportionate to its risk and use the existing feature folders and records; do not add documents that repeat the same facts.

Implement one feature at a time using this sequence:

1. Frame the outcome, current behavior, boundaries, assumptions, and non-goals.
2. Write or update the feature specification and observable acceptance criteria under `features/`.
3. Choose a rigor level and briefly explain why.
4. Inspect the existing scenes, scripts, project settings, and affected consumers.
5. Propose the bounded implementation plan when review is needed.
6. Implement only the authorized feature scope.
7. Run checks that support the acceptance claims; record the actual result and conditions in the feature `WORK_RECORD.md`.
8. Playtest user-visible game behavior when possible; keep an unavailable or unrun check visibly pending.
9. Explain the relevant scene/script path, important decisions, evidence limits, and first debugging step. For this learning project, do not mark the user explanation complete until the user demonstrates understanding in a walkthrough.
10. Review the Git diff and update linked records affected by the change.
11. Commit one logical change only when authorized and appropriate.

Use `features/WORK_RECORD_TEMPLATE.md` for a new work record. Keep requirement/expected behavior in `SPEC.md`, criteria in `ACCEPTANCE.md`, and observed results in `WORK_RECORD.md`. A criterion is not passed just because it has been implemented. A successful command does not prove visual or gameplay behavior unless it observes that behavior.

Keep these statuses separate in reports and records: implementation, verification, human explanation, work disposition, and release. Release is not implied by implementation or verification.

Do not ask an AI agent to “build the whole game” in one task. Bound every task by a feature and its acceptance criteria.

## Change control

- Do not modify unrelated files.
- Do not silently refactor working systems.
- Preserve existing behavior unless the feature specification requires a change.
- Explain architectural changes before implementing them.
- Prefer the smallest change that satisfies the acceptance criteria.
- Do not introduce a dependency or addon without documenting why it is needed.
- Do not create placeholder systems that are not needed by the current milestone.

## Code quality

- Type variables, parameters, return values, signals, and exported properties.
- Use descriptive names and avoid magic numbers.
- Keep functions short enough to have one clear responsibility.
- Avoid duplicated logic and large manager classes.
- Handle invalid state deliberately rather than relying on accidental behavior.
- Treat warnings as defects to investigate, especially unsafe or untyped GDScript warnings.

## Validation and reporting

Every implementation task must report:

```text
IMPLEMENTATION REPORT

Files created:
- ...

Files modified:
- ...

Architecture:
- ...

Signals added:
- ...

Dependencies:
- ...

How to test:
1. ...
2. ...

Known limitations:
- ...

Statuses:
- Implementation: ...
- Verification: ...
- Human explanation: ...
- Work disposition: ...
- Release: ...

No unrelated files modified.
```

Automated tests are required for deterministic gameplay logic when practical. Human playtesting is still required for movement feel, combat feel, pacing, readability, and fun.
