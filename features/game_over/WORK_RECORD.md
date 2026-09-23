# Game Over

Outcome: Clearly end a run when the player's health reaches zero, completing the V0.1 lose condition.

Mode / rigor: Feature change, standard. This is a user-visible run-state transition driven by a health signal and must preserve the existing HUD and boss victory state.

Current behavior: The player stops moving and attacking on death, but Main does not show a game-over message or pause the rest of the run.

Scope and boundaries: Observe player death in Main, show a centered `GAME OVER` label, and pause the scene tree. No restart/respawn, scene change, new global state, or combat changes.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [main.gd](../../game/world/main.gd) and [main.tscn](../../game/world/main.tscn). Main observes the player's HealthComponent `died` signal and reveals a CanvasLayer label before pausing the scene tree. The Health HUD stays visible. [test_game_over.gd](../../tests/test_game_over.gd) covers lethal damage, zero-health HUD, game-over feedback, and pause behavior.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Lethal damage shows game-over and pauses the run | `run-godot.ps1 --headless --script res://tests/test_game_over.gd` | passed | Player health reached 0, `GAME OVER` appeared, `HP: 0 / 100` remained visible, and the tree paused. |
| Existing gameplay and boss victory remain intact | All `tests/test_*.gd` scripts | passed | All nine gameplay integration tests passed, including boss victory and dungeon traversal. |
| Editor import, runtime launch, and diff formatting | Godot 4.7.2 editor/runtime checks and `git diff --check` | passed | All exited 0; Godot emitted the known non-blocking Windows root certificate-store warning. |
| Game-over label readability | User playtests a normal death in the graphical game | passed | User confirmed the game-over screen and behavior appeared as described. |

Human explanation: pending. Walk through HealthComponent's signal, Main's game-over UI/state handling, and the player's local death behavior.

Limitations and unknowns: No restart or recovery is available after death; close/relaunch the game to begin another run.

Statuses: Implementation complete; automated and graphical verification passed; human explanation pending; work open; release not requested.

Next action and owner: Assistant: proceed to the next roadmap item, animation polish. Human explanation remains a learning follow-up.
