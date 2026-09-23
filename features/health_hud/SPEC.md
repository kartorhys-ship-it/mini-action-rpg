# Health HUD

## Purpose

Make the player's health and incoming damage visible during play so combat outcomes are understandable.

## Behavior

- Show the player's current and maximum health as text and as a horizontal bar in the top-left HUD.
- Start at `HP: 100 / 100` with a full bar for the default player health.
- Update both readouts whenever the player HealthComponent emits `health_changed`.
- Show an empty bar and `HP: 0 / 100` when the player is defeated.
- Keep the health HUD read-only; it observes health and never changes it.

## Ownership and boundaries

- The HUD lives under the main scene's CanvasLayer.
- The HUD script connects to the player HealthComponent using a scene-configured NodePath.
- HealthComponent remains the sole owner of health values and damage/death behavior.

## Must not

- Add healing controls, health potions, game-over or respawn flow, damage animation, or enemy changes.
- Modify player health values from the HUD.
- Add global state, autoloads, external dependencies, or unrelated UI.
