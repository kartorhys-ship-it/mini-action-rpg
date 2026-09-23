# Enemy Combat

## Purpose

Give the slime a readable, bounded way to threaten the player so the player must engage or avoid it rather than only chase it for target practice.

## Behavior

- The living slime damages the player while they are within its contact area.
- A first contact deals 10 damage immediately; continued contact deals no more than one hit per second.
- The slime approaches to contact range and stops there. It does not push the player or damage them at range.
- Moving out of contact range stops further damage. Re-entering range can start a new hit immediately.
- A defeated slime cannot damage the player.
- The player's existing HealthComponent remains the owner of health and death state; damage reaches it through the player's public `receive_damage(amount)` method.

## Ownership and boundaries

- The Slime scene owns a contact Area2D and local damage cadence.
- The player owns the public incoming-damage boundary and delegates to HealthComponent.
- The slime continues using its existing target reference; no global player lookup or autoload is introduced.
- Damage and interval are exported tuning values; initial values are 10 damage and 1.0 seconds.

## Must not

- Add enemy attacks, projectiles, animations, knockback, invulnerability frames, a health HUD, game-over flow, or additional enemy types.
- Change player sword, gold pickup, training dummy, or player health component behavior.
- Allow damage to continue after the slime is defeated or while the player is outside the contact area.
