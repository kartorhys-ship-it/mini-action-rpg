# Health Potion

Outcome: Add one reliable recovery item so the player can restore health lost to slime contact.

Mode / rigor: Feature change, standard. This crosses item collision, player healing, health ownership, and HUD observation.

Current behavior: Player health can be reduced by slime contact and is visible on the HUD. The shared HealthComponent already clamps healing, but there is no healing pickup in the room.

Scope and boundaries: One fixed room pickup that restores up to 30 HP by touch and is consumed only if it heals. No inventory, hotkey, drops, or persistence.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [health_potion.tscn](../../game/items/health_potion.tscn) and [health_potion.gd](../../game/items/health_potion.gd), placed at (560, 400) in [main.tscn](../../game/world/main.tscn). Touching it calls the player's `receive_healing(30)` boundary; it is removed only if health increases. The player delegates to HealthComponent and reports whether any healing occurred.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Pickup restores 30 from 60 to 90, updates HUD, and consumes once | `run-godot.ps1 --headless --script res://tests/test_health_potion.gd` | passed | Integration test observed the signal-driven label update and removal after successful healing. |
| Full-health persistence, maximum clamp, and dead-player handling | Same integration test | passed | Pickup remained at 100 HP; separate potion healed 90 to 100; direct healing was rejected at zero/dead. |
| Existing combat, HUD, gold, and dummy behavior | Enemy combat, health HUD, slime, gold, and dummy integration tests | passed | All five neighboring gameplay test scripts pass. |
| Project imports and runs | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Diff formatting | `git diff --check` | passed | Exit 0; only line-ending conversion notices. |
| Potion visibility and room placement | User plays graphical game | not run | Requires interactive check. |

Human explanation: pending. Walk through the pickup's successful-heal contract and why it stays when health is full.

Limitations and unknowns: The potion heals automatically on touch and cannot be stored or saved. Visual readability and placement require a user playtest.

Statuses: Implementation complete; automated verification passed; graphical potion visibility/playtest pending; human explanation pending; work open; release not requested.

Next action and owner: User: launch the game, find the `HEAL +30` bottle below/right of the slime and dummy, take damage, and walk into it; confirm health rises by 30 and the bottle disappears. Assistant: address any mismatch — user and assistant.
