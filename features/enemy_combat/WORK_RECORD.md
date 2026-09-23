# Enemy Combat

Outcome: Make the slime a threat by dealing bounded contact damage through the player's existing health owner.

Mode / rigor: Feature change, standard. This adds player-visible combat behavior across the enemy, player, physics, and health boundaries.

Current behavior: The slime pursues and stops near the player. The player HealthComponent supports damage and death; it now receives contact damage through the player's public boundary.

Scope and boundaries: Slime contact damage only, with immediate first hit, a one-second repeat interval, and player health delegation. No player HUD or game-over behavior.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [slime.gd](../../game/enemies/slime.gd), [slime.tscn](../../game/enemies/slime.tscn), and [player.gd](../../game/player/player.gd). The slime owns an Area2D contact zone and applies 10 damage immediately, then at one-second intervals while its target overlaps. Its approach stop distance is 32 px so the contact area reaches the player. The player exposes `receive_damage(amount)` and delegates to its existing HealthComponent. Defeat disables the contact area.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Contact hit, repeat cadence, range exit, and defeated-state behavior | `run-godot.ps1 --headless --script res://tests/test_enemy_combat.gd` | passed | Verified 100→90 immediately, remained 90 before one second, then reached 80; leaving range and defeating slime prevented additional damage. |
| Existing slime, gold, and dummy behavior | `test_slime_ai.gd`, `test_gold_drops.gd`, and `test_training_dummy.gd` | passed | All three neighboring integration checks passed after contact-range tuning. |
| Project imports and runs | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Diff formatting | `git diff --check` | passed | Exit 0; only line-ending conversion notices. |
| Damage readability and gameplay feel | User plays graphical game | not run | The health HUD now shows current health; user still needs to confirm visible decrement and the zero-health control stop. |

Human explanation: pending. Walk through the slime contact area/cooldown, player damage boundary, and health component ownership.

Limitations and unknowns: There is no hurt flash, game-over, or respawn flow. The health HUD makes individual hits visible; damage tuning may still need adjustment after playtesting.

Statuses: Implementation complete; automated verification passed; graphical playtest pending; human explanation pending; work open; release not requested.

Next action and owner: User: confirm that the health HUD visibly decreases while the slime remains in contact and that controls stop at zero — user and assistant.
