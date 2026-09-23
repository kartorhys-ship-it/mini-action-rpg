# Sword Attack

Outcome: Add the player's first bounded combat action, setting up a stable attack interface for the training dummy and enemies.

Mode / rigor: Feature change, standard. This is a player-visible action with timed state and an interface to future targets.

Current behavior before this feature: Player movement and health component were implemented, but there was no attack input or damage target. See the player movement and health Work Records.

Scope and boundaries: Player facing, attack input, timed active window/cooldown, and a damage receiver call for compatible targets. Dummy, enemy implementation, HUD, game-over flow, and attack animations are excluded.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete for the player attack action. [player.gd](../../game/player/player.gd) owns facing, the one-hit-per-swing list, and attack timing (`attack_duration` 0.16 s, `attack_cooldown` 0.75 s, `attack_visual_duration` 0.7 s, `attack_damage` 25). [main.tscn](../../game/world/main.tscn) owns the attack Area2D and yellow slash visual. Space is mapped to `attack` in [project.godot](../../project.godot). The hit area detects physics layer 4 and calls `receive_damage(amount)` on compatible bodies.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Project parses and imports | Godot 4.7.2 `--headless --editor --quit` via `run-godot.ps1` | passed | Exit 0; Godot reports a pre-existing Windows root certificate-store warning. |
| Project launches and runs | Godot 4.7.2 `--headless --quit-after 120` via `run-godot.ps1` | passed | Exit 0; no script or scene errors reported. |
| Attack timing, direction, and visual | Interactive playtest; Space and four facings | not run | User confirmed the sword is visible; timing and four-direction visual check remain pending. |
| One hit per swing against a compatible target | Godot main-scene physics test in `tests/test_training_dummy.gd` | passed | One swing reduced the training dummy from 100 to 75; the test would fail if repeated hits applied. |
| Existing movement preserved | Inspect movement path and input map | passed | Movement input, velocity assignment, and key bindings are unchanged; interactive regression test still recommended. |
| Diff formatting | `git diff --check` | passed | No whitespace errors; Git reported only existing LF-to-CRLF notices. |

Human explanation: pending. Walk through attack state, facing, and the target damage contract.

Limitations and unknowns: The slash is simple placeholder feedback, not an animation. Manual targeting and feel checks remain pending. An attack cannot hit bodies outside the attack zone's collision layer (4).

Statuses: Implementation complete; verification inconclusive pending interactive playtest of attack behavior; work open; release not requested.

Next action and owner: User: verify the training dummy takes one hit per Space press and try attack direction; assistant: fix any observed mismatch.
