# Training Dummy

## Purpose

Provide a stationary target that makes the player's sword damage and the health component observable in the running game.

## Behavior

- A wooden training dummy is present in the room in front of the player's starting position.
- The dummy starts with 100 health and receives damage through `receive_damage(amount: float)`.
- It owns a HealthComponent and does not modify health values directly.
- A small label above it shows current / maximum health and updates when damaged.
- At zero health, it stays in the room, changes appearance, and shows `DUMMY DOWN`.
- The dummy does not move, attack, respawn, or affect player health.

## Ownership and boundaries

- The dummy scene owns its static collision body, placeholder wooden art, health component, and health label.
- The dummy's body is on physics layer 4 so the player's attack area can detect it.
- The existing player attack owns hit detection and invokes the public damage receiver.

## Must not

- Add enemy AI, player HUD, damage numbers, drop items, respawn controls, or game-over behavior.
- Change the player movement or attack behavior except to repair a demonstrated integration issue.
- Add external assets or dependencies.
