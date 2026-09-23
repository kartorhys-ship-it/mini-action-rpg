# Gold Drops and Counter

Outcome: Make a defeated slime produce a visible reward the player can collect and count.

Mode / rigor: Feature change, standard. This links enemy death, a collectible physics area, player-owned currency state, and a UI observer.

Current behavior: The slime can be defeated but creates no item. The player has no gold state or counter. Game design calls for gold drops to add to the player's gold when collected.

Scope and boundaries: One guaranteed 1-gold coin per defeated slime, touch collection, player GoldComponent, and a minimal gold counter. No drop behavior for the dummy, persistence, spending, or health HUD.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [gold_pickup.tscn](../../game/items/gold_pickup.tscn) and [gold_pickup.gd](../../game/items/gold_pickup.gd), spawned once from the slime's death handler. Touching it calls the player's `collect_gold` contract. The player owns [gold_component.gd](../../game/player/gold_component.gd); [gold_counter.gd](../../game/ui/gold_counter.gd) observes its change signal. The main scene configures the drop and counter.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| One drop on slime death, no duplicate, and correct defeat position/value | `run-godot.ps1 --headless --script res://tests/test_gold_drops.gd` | passed | Test confirmed one 1-gold pickup spawns at the slime's defeat position. |
| Pickup increments gold, updates counter, and removes coin | Same deterministic main-scene physics test | passed | Teleported test bodies require explicit transform refresh before checking physics overlap; actual pickup `body_entered` behavior was exercised. |
| Existing slime and dummy behavior | `test_slime_ai.gd` and `test_training_dummy.gd` | passed | Both prior integration tests pass. |
| Project imports and runs | Godot 4.7.2 headless import/runtime | not run | Run after final edits. The known Windows root certificate-store warning is non-blocking. |
| Visual coin readability and collection feel | User playtest | not run | Pending implementation. |

Human explanation: The slime's health component emits `died`; the slime schedules one pickup to spawn at its world position. The pickup is a visible Area2D and listens for bodies. On touching a player, it calls `collect_gold(1)` once and removes itself. The player's GoldComponent increments the total and emits `gold_changed`; the counter listens to that signal and changes its label. Gold resets when the game session restarts.

Limitations and unknowns: Gold is session-only and has no spending use yet. Only the normal slime drops gold; no other persistence or economy behavior exists.

Statuses: Implementation complete; automated verification passed; manual visual/play-feel playtest pending; work open; release not requested.

Next action and owner: User, launch the game, defeat the slime with Space, confirm the coin appears, then walk into it and confirm the counter changes to `GOLD: 1`. Assistant to address any discrepancy.
