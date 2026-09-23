# Mini Action RPG

A small 2D top-down action RPG built as a controlled experiment in AI-assisted Godot development.

## Current status

Phase 0 — project foundation.

The repository currently contains project rules, design notes, architecture notes, and the initial folder layout. Gameplay has intentionally not been implemented yet.

## Target V0.1

```text
Enter dungeon
      ↓
Fight slimes
      ↓
Collect gold and a health potion
      ↓
Reach the boss room
      ↓
Defeat the boss
      ↓
YOU WIN
```

The first version should contain only:

- WASD movement
- A basic sword attack
- Player health and healing
- One simple enemy type
- One boss
- One small dungeon
- Gold drops and one health potion
- Health and gold HUD
- Game-over and victory states

## Project structure

```text
project.godot
AGENTS.md
README.md
docs/
features/
game/
tests/
assets/
```

See [docs/GAME_DESIGN.md](docs/GAME_DESIGN.md), [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), and [docs/ROADMAP.md](docs/ROADMAP.md) for the working plan.

## Development principles

- Work in small vertical slices.
- Write a feature specification before implementation.
- Review the plan before changing code.
- Run checks and playtest after each feature.
- Review and commit one logical change at a time.
