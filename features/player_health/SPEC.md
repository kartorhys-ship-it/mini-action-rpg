# Player Health

## Purpose

Track the player's health, apply damage and healing within bounds, and report when the player reaches zero health.

## Contract

- Maximum health defaults to 100 and is configurable on the component.
- Current health starts at maximum health.
- `take_damage(amount)` reduces health by a positive amount and clamps the result to zero.
- `heal(amount)` increases health by a positive amount and clamps the result to maximum health.
- Non-positive amounts have no effect.
- Reaching zero health marks the component dead and emits `died` once.
- A dead component ignores further damage and healing; revival is outside this feature.
- Emit `health_changed(current, maximum)` when initialized and whenever current health changes.

## Ownership and boundaries

- The player owns a child HealthComponent.
- The component owns health values and health signals.
- The component does not move the player, create UI, or decide game-over flow.
- Future combat and item systems call the component's public methods; they do not edit its fields directly.

## Must not

- Add a health bar, game-over screen, enemies, combat, potions, or debug keyboard controls.
- Add Autoloads, global state, or external dependencies.
