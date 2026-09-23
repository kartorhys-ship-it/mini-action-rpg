# Health Potion

## Purpose

Give the player one visible recovery item in the starting room to offset slime contact damage.

## Behavior

- One potion is placed in the room at a fixed, visible location.
- Touching it while below maximum health restores up to 30 health, clamped to the player's maximum.
- The potion disappears only when it successfully restores health; touching at full health leaves it available.
- The existing health HUD updates through the HealthComponent's `health_changed` signal.
- The potion cannot revive a dead player.

## Ownership and boundaries

- The HealthPotion scene owns its art, contact area, and one-time pickup behavior.
- The player exposes a `receive_healing(amount)` boundary and delegates healing to its HealthComponent.
- HealthComponent remains the only owner of health and maximum-health limits.
- Main scene owns the potion's placement; no drop table or inventory is added.

## Must not

- Add an inventory, potion stack, hotkey/use action, random drops, multiple potion variants, or persistence.
- Change enemy, gold, sword, health HUD, or game-over behavior.
- Consume a potion if it cannot restore any health.
