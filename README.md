# Mini Action RPG

A small 2D top-down action RPG built as a controlled experiment in AI-assisted Godot development.

## Current status

The main scene now contains connected Entry, Slime Den, and Boss Room areas. The Boss Room contains a 300-HP Large Slime; defeating it displays `YOU WIN`. Player movement, health/HUD, sword attack, training dummy, normal slime combat, health potion, and gold drop/counter are implemented. Automated tests cover boss combat, room passages, and pickups; boss difficulty and visual readability still need user playtesting.

The project launches into a placeholder dungeon room with an enclosed player body, a stationary training dummy, a chasing slime, a health potion, a player health bar, a gold counter, and camera. Use WASD or the arrow keys to move, Space to swing the sword, defeat the slime, and walk into its coin to collect 1 gold. Walk into the `HEAL +30` potion while injured to restore health; at full health it remains available. The dummy and slime show their own health above them. See the feature Work Records for verification details and limits.

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
