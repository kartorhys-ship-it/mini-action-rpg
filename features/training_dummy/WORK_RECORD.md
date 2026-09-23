# Training Dummy

Outcome: Make sword damage and the existing health component testable in a playable scene.

Mode / rigor: Feature change, standard. This integrates physics hit detection, the player's attack, a health signal consumer, and visible feedback.

Current behavior: The player can swing a sword into empty space. There is no compatible target. Player attacks call `receive_damage(amount)` on bodies in collision layer 4.

Scope and boundaries: Add one stationary damage-receiving dummy with 100 health, a health label, and a defeated appearance. Exclude player HUD, AI, player damage, respawn, and drops.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [training_dummy.tscn](../../game/enemies/training_dummy.tscn) and [training_dummy.gd](../../game/enemies/training_dummy.gd), instanced in [main.tscn](../../game/world/main.tscn) at (480, 330). It is a StaticBody2D on layer 4 with a 100-point HealthComponent, a health label, and defeated-state feedback. The main scene places it 60 pixels below the player's initial center, within the down-facing attack range. [test_training_dummy.gd](../../tests/test_training_dummy.gd) exercises the main-scene attack-to-dummy path.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Dummy scene and health feedback | `run-godot.ps1 --headless --script res://tests/test_training_dummy.gd` | passed | Exit 0; the script verified 100/100 initial health, 75/100 after one attack, and `DUMMY DOWN` at zero. |
| Sword-to-dummy damage integration | Deterministic main-scene physics test | passed | The actual player attack hit the dummy once for 25; no multiple-hit regression observed in the assertion. Manual Space playtest remains pending. |
| Project imports and runs | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Visible placement and keyboard hit | User plays main scene, faces down, presses Space | not run | Automated test does not establish visual readability or desktop input behavior. |
| Diff formatting | `git diff --check` | pending | Run after final documentation updates. |

Human explanation: pending. Walk through the Area2D-to-receiver-to-health-signal path.

Limitations and unknowns: Placeholder art; no respawn after the dummy reaches zero health. The dummy's small overhead number is only target feedback, not the player's health HUD. Manual readability/playfeel checks remain necessary.

Statuses: Implementation complete; verification inconclusive pending live playtest; work open; release not requested.

Next action and owner: User: run the game, confirm the dummy and `100 / 100` label are visible, face down and press Space once, and confirm the label becomes `75 / 100`. Assistant: address any discrepancy, then begin Slime AI.
