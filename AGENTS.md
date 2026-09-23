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

Implement one feature at a time using this sequence:

1. Define the feature.
2. Write or update its specification and acceptance criteria under `features/`.
3. Inspect the existing architecture before proposing changes.
4. Present an implementation plan for review.
5. Implement only the approved feature scope.
6. Run Godot checks and relevant tests.
7. Playtest the feature manually.
8. Review the Git diff.
9. Commit one logical change with a descriptive message.

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

No unrelated files modified.
```

Automated tests are required for deterministic gameplay logic when practical. Human playtesting is still required for movement feel, combat feel, pacing, readability, and fun.
