# Sword Attack

## Purpose

Give the player a simple, responsive melee attack as the first combat action in the V0.1 playable loop.

## Behavior

- Press the `attack` input action to request a sword swing.
- The default keyboard binding for `attack` is Space.
- The player faces the most recent non-zero movement direction; initially facing down.
- An attack has a short active hit window in front of the player, a longer visible slash cue so the player can read the action, and a configurable cooldown.
- Each eligible target may be hit at most once per swing.
- The attack is inactive between swings and cannot be retriggered during cooldown.
- Attacks communicate damage to a target through a small typed damage-receiver contract; targets are not implemented by this feature.

## Ownership and boundaries

- Player attack behavior belongs to the player scene/script.
- Use an `Area2D` owned by the player to detect targets in the attack zone.
- Potential targets are on physics collision layer 4; the player hit area only detects that layer.
- An attack calls a target's public `receive_damage(amount: float)` method; it does not access target health internals.
- The training dummy and enemy health are separate features.

## Must not

- Add a health bar, enemy, training dummy, game-over flow, or input debug/test controls.
- Add animation assets or external dependencies; a simple visible attack-zone/debug-free shape may be used only if needed for feedback.
- Change movement speed or room layout.
