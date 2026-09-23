# Slime AI

Outcome: Add one simple pursuer that gives the player a moving enemy target and makes the sword combat loop more representative.

Mode / rigor: Feature change, standard. This adds visible enemy movement, target ownership, health, and interaction with the existing player attack and room collision.

Current behavior: The player can move and swing at a stationary training dummy. There is no moving enemy. Game design specifies a 30-health slime that detects and chases the player; the separate roadmap Enemy Combat milestone will add player damage.

Scope and boundaries: One 30-health slime with short-range direct pursuit, a stop distance, health label, and defeated state. Contact damage is implemented separately in [Enemy Combat](../enemy_combat/WORK_RECORD.md); respawn, pathfinding, player HUD, and enemy variety are out of scope. A guaranteed gold drop is implemented separately in [Gold Drops](../gold_drops/WORK_RECORD.md).

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [slime.tscn](../../game/enemies/slime.tscn) and [slime.gd](../../game/enemies/slime.gd), instanced in [main.tscn](../../game/world/main.tscn) at (650, 270). It starts with 30 health, detects the player within 180 pixels, pursues at 90 pixels/second, and originally stopped 38 pixels away. Enemy Combat later adjusted the live stop distance to 32 pixels so the contact area can overlap the player. Its target is supplied by the main scene as `../Player`; walls are on its collision mask. It uses the existing health component and `receive_damage(amount)` contract. The game design's attack binding was corrected to match the tested Space binding.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Detection range, pursuit, and stopping separation | `run-godot.ps1 --headless --script res://tests/test_slime_ai.gd` | passed | Exit 0; test verified idle outside range, approach after entering range, and separation within the configured stopping interval. |
| Existing sword damages/kills slime | Same deterministic main-scene physics test | passed | One 25-point swing changed 30 to 5; a second displayed `SLIME DOWN`. |
| Existing training dummy behavior | `run-godot.ps1 --headless --script res://tests/test_training_dummy.gd` | passed | Exit 0; existing 100-to-75 and defeated-state test still passes. |
| Main scene import/runtime | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Wall collision, visual readability, and gameplay feel | User plays the graphical main scene | not run | Automated tests do not establish presentation or feel; wall response remains an interactive check. |
| Diff formatting | `git diff --check` | passed | No whitespace errors; Git only printed its LF-to-CRLF conversion notices. |

Human explanation: pending. Walk through the target NodePath, range check, velocity, wall collision, and health signal path.

Limitations and unknowns: Direct pursuit cannot navigate around obstacles. Visual readability, wall response, and chase feel need a live playtest.

Statuses: Implementation complete; verification inconclusive pending live playtest; work open; release not requested.

Next action and owner: User: launch the updated scene and check chase distance/wall response while testing the combined Enemy Combat feature — user and assistant.
