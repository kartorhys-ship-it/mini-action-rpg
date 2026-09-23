# Player Movement

## Purpose

Let the player move around the existing dungeon using keyboard input while respecting the room walls.

## Input and behavior

- Use the existing `move_left`, `move_right`, `move_up`, and `move_down` Godot input actions.
- Bind those actions to A/D/W/S and the corresponding arrow keys.
- Support movement in eight directions.
- Normalize diagonal input so diagonal movement is not faster.
- Use a fixed, exported movement speed on the player script.
- Stop immediately when there is no movement input.
- Move through `CharacterBody2D` physics so walls block the player.
- Keep the current camera behavior and player placeholder.

## Ownership

- The player script reads input and sets velocity/moves the `CharacterBody2D`.
- The main world continues to own the dungeon and wall bodies.
- Do not add a movement component scene until another character needs to reuse it.

## Dependencies

- Existing `Player` node in `game/world/main.tscn`.
- Existing wall collision bodies and camera.

## Must not

- Add health, combat, attacks, enemies, items, or HUD.
- Change the room layout or collision boundaries.
- Add an Autoload or external addon.
