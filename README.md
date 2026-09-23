# Mini Action RPG

A small 2D top-down action RPG built as a controlled experiment in AI-assisted Godot development.

## Current status

Milestone 1 implementation is in place. Engine launch was checked; visual inspection and manual wall-collision playtest remain pending.

The project launches into a placeholder dungeon room with an enclosed player body and camera. See [the main-scene Work Record](features/main_scene/WORK_RECORD.md) for the evidence and its limits. Player movement is the next implementation slice; its scope and current status are in [features/player_movement/](features/player_movement/).

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

See [docs/GAME_DESIGN.md](docs/GAME_DESIGN.md), [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md), [docs/ROADMAP.md](docs/ROADMAP.md), and [docs/ENGINEERING_METHOD.md](docs/ENGINEERING_METHOD.md) for the working plan and evidence practices.

## Run the project

On Windows, start the editor with:

```powershell
./run-godot.ps1 --editor
```

Run the game directly with:

```powershell
./run-godot.ps1
```

The portable Godot executable and its local cache folders are stored under `tools/godot/` and ignored by Git.

## Development principles

- Work in small vertical slices.
- Write a feature specification before implementation.
- Review the plan before changing code.
- Run checks and playtest after each feature.
- Review and commit one logical change at a time.
