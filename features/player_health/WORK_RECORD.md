# Player Health

Outcome: Give the player a bounded health value that future combat and item features can damage or heal.

Mode / rigor: Feature change, standard. This adds reusable player state and a signal boundary consumed by future features.

Current behavior before this change: The player was a moving `CharacterBody2D` with no health state or health component. The design sets player maximum health to 100.

Scope and boundaries: Add a child HealthComponent with maximum/current health, damage/heal methods, and health/death signals. Exclude the health HUD, game-over flow, enemies, attacks, potions, and debug controls.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [health_component.gd](../../game/player/health_component.gd), attached as a child in [main.tscn](../../game/world/main.tscn). The player listens to the component's `died` signal and stops its physics movement when death occurs. `take_damage()` and `heal()` clamp values and ignore non-positive amounts; dead components cannot be healed or damaged.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Damage and death behavior through a caller | Godot main-scene test `tests/test_training_dummy.gd` | passed | A 25-point attack reduced the dummy-owned HealthComponent from 100 to 75; a further 100 damage reached zero and updated the `died` consumer. This exercises shared component behavior, but not the player's own death reaction. |
| Healing, upper/lower bounds, invalid amounts, and signal counts | Direct component contract test | not run | The dummy test covers a normal damage hit and the zero-health transition only; the rest of the public contract remains unverified. |
| Project imports and launches | Godot 4.7.2 `--headless --editor --quit`, then `--headless --quit-after 120` | passed | Both commands exited 0. Godot emitted the known non-blocking Windows root certificate-store warning. |
| No out-of-scope systems added | Inspect the scene and scripts | passed | No HUD, game-over flow, enemies, combat, potions, or debug controls were added. |

Human explanation: pending. Walk through state ownership, signal consumers, and what happens after death.

Limitations and unknowns: Player health values are not visible in-game; no player HUD or game-over flow exists. Healing, edge cases, signal counts, and the player's death reaction still need tests.

Statuses: Implementation complete; verification inconclusive overall; work open; release not requested.

Next action and owner: Add focused tests for healing/bounds and the player's death response when combat/item flows need them; the player health HUD remains a later roadmap feature — assistant.
