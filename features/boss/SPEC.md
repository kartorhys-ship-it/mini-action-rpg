# Boss — Large Slime

## Purpose

Deliver the game's capstone combat encounter in the marked Boss Room and complete the win condition when the boss is defeated.

## Behavior

- One large slime boss waits in the Boss Room, acquires the player when they approach, and retains aggro during a chase across rooms.
- When the chase crosses a room boundary, the boss routes through the centerline of the connected doorway rather than pushing directly into a partition.
- The boss has 300 health, moves faster than the normal slime, and deals stronger contact damage.
- The existing Space sword can damage the boss and its health is displayed above it.
- The boss enters a defeated state at zero health and stops moving/attacking.
- Defeating the boss displays `YOU WIN` on the screen and pauses gameplay so the player cannot continue moving or attacking after victory.
- The normal slime and its guaranteed 1-gold drop remain unchanged; the boss does not drop gold.

## Ownership and boundaries

- BossSlime is a tuned instance of the existing Slime scene/script, with larger art/collision and boss-specific health/combat/display tuning.
- The boss owns its HealthComponent; the player's existing attack and HealthComponent boundaries remain in use.
- The Main scene observes the boss HealthComponent's `died` signal and reveals the victory label.

## Must not

- Add a new boss AI framework, projectiles, phases, attack animations, boss health HUD, cutscene, restart flow, or game-over flow.
- Add a boss gold drop or change the normal slime's stats/drop.
- Add another enemy type or external dependencies/assets.
