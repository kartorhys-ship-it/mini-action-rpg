# Health HUD

Outcome: Make player health and slime contact damage visible so the user can understand why the player eventually stops responding.

Mode / rigor: Feature change, standard. This is player-facing feedback that observes an existing gameplay signal and resolves ambiguity during combat.

Current behavior: Player health starts at 100 and slime contact deals 10 damage per second. At zero health the player stops moving and attacking, but no player HUD indicates the cause.

Scope and boundaries: Read-only player health label and bar in the main scene's CanvasLayer. No health mutation, healing, potions, game-over, or respawn.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [health_hud.gd](../../game/ui/health_hud.gd), instanced in [main.tscn](../../game/world/main.tscn) beside the existing gold counter. It listens to HealthComponent's `health_changed` signal, displays `HP: current / max`, and scales/colors a bordered bar green→amber→red as health falls. The HUD has no health-mutating methods.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Initial health and signal-driven updates | `run-godot.ps1 --headless --script res://tests/test_health_hud.gd` | passed | Test verified `HP: 100 / 100`, then `HP: 90 / 100` and bar values of 100 and 90. |
| Zero-health display and ownership | Same integration test | passed | At zero it displayed `HP: 0 / 100` with an empty bar; HealthComponent remained owner of `is_dead`. |
| Project imports and runs | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Neighboring gameplay | Enemy combat, slime AI, gold, and dummy integration tests | passed | All four existing gameplay tests pass with the HUD installed. |
| Diff formatting | `git diff --check` | passed | Exit 0; only line-ending conversion notices. |
| HUD visibility and readability | User plays graphical game | not run | Requires interactive visual check. |

Human explanation: pending. Walk through the HealthComponent signal and read-only HUD observer.

Limitations and unknowns: The HUD displays health but does not change the existing no-respawn death behavior. Visual size/readability needs a live check. Godot emits a non-blocking Windows root certificate-store warning during headless checks.

Statuses: Implementation complete; automated verification passed; graphical visibility check pending; human explanation pending; work open; release not requested.

Next action and owner: User: relaunch the game, confirm `HP: 100 / 100` and the green bar appear below the gold counter, then stand near the slime and observe the number/bar fall — user and assistant.
