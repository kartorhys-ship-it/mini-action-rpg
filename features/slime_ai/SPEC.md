# Slime AI

## Purpose

Add the first living enemy: a simple slime that notices the player nearby and approaches, creating a moving target for the sword.

## Behavior

- One slime appears to the right of the player start with 30 health, as specified by the game design.
- It stays still while the player is outside its configurable detection range.
- When the player enters range, it moves directly toward them at a configurable speed.
- It stops at a configurable separation instead of overlapping the player; contact damage is a later Enemy Combat feature.
- Its health is displayed above it; the existing sword can damage it through `receive_damage(amount: float)`.
- At zero health it stops, remains visible, and displays `SLIME DOWN`.
- It collides with room walls and uses direct pursuit; pathfinding is not included.

## Ownership and boundaries

- The Slime scene owns its movement, target reference, health component, placeholder art, and health label.
- The main scene supplies the player reference through an exported NodePath; no Autoload or global player lookup is introduced.
- The slime is on collision layer 4 so the existing player attack detects it.

## Must not

- Damage the player, perform attack animations, drop gold, respawn, or add enemy-specific HUD in this feature.
- Add pathfinding, multiple enemies, new items, or external assets/dependencies.
- Change player movement, sword behavior, or training dummy behavior.
