# Main Scene and Empty World

## Purpose

Create the first launchable game scene: a simple enclosed dungeon floor with a visible player placeholder and a camera that frames the room.

## Requirements

- The project launches directly into this scene.
- The world is a 2D top-down room with a clearly visible floor and enclosing walls.
- The player placeholder is visible near the center of the room.
- A camera shows the room and player at the configured 960 × 540 viewport.
- The scene uses built-in Godot nodes and generated placeholder visuals; no external art is required.
- Walls have collision so the player is enclosed when movement is added.

## Boundaries

- This feature does not implement movement, combat, enemies, HUD, items, or game-state flow.
- Keep room construction local to the world scene for this first milestone.
- Player is a visual placeholder with a collision body, ready for movement in the next milestone.
