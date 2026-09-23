# Player Movement

Outcome: Move the player around the existing dungeon with keyboard controls while the room walls constrain movement.

Mode / rigor: Feature change, standard. It introduces user-visible gameplay behavior, input configuration, physics movement, and interaction with existing collision boundaries.

Current behavior before this change: The player was a stationary `CharacterBody2D` in `game/world/main.tscn`, with collision mask 1; dungeon walls are `StaticBody2D` on layer 1. No movement script or input map actions existed.

Scope and boundaries: Add keyboard movement to the existing player, preserve its placeholder and camera, normalize diagonal input, and use the existing walls. Health, combat, enemies, items, and HUD are excluded.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [player.gd](../../game/player/player.gd), attached to the player in [main.tscn](../../game/world/main.tscn); keyboard actions are configured in [project.godot](../../project.godot). The speed is exported and defaults to 220 pixels per second. `Input.get_vector()` normalizes the four action strengths, then velocity is assigned directly and `move_and_slide()` handles physics collision.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| WASD movement | User playtest, 2026-09-24 | passed | User confirmed WASD works. |
| Up/down arrow movement | User playtest, 2026-09-24 | passed | User confirmed Up and Down arrows work. |
| Left/right arrow movement | User playtest after repair, 2026-09-24 | passed | Initial mappings were `4194311` (Insert) and `4194313` (Pause). They were corrected to Godot's `4194319` (Left) and `4194321` (Right); user confirmed the repair works. |
| Diagonal speed and immediate stop | Interactive input playtest | not run | Not reported yet. |
| Wall collision and camera behavior | Move into each wall and observe player/camera framing | not run | Runtime collision and camera behavior still need a manual playtest. |
| No startup parser/runtime errors | Godot 4.7.2 `--headless --editor --quit`, then `--headless --quit-after 120` | passed | Both commands exited 0. Godot emitted a non-blocking Windows root certificate-store warning and loaded its built-in CA bundle. |
| No features outside player movement were added | Inspect the current change scope | passed | Changes are limited to player movement code/configuration, its spec/record, and project status documentation. |

Human explanation: pending. Walk through input-to-velocity-to-physics flow, wall collision ownership, and the limit of headless launch evidence.

Limitations and unknowns: Initial speed is 220 pixels per second and remains subject to feel-based playtesting. Camera framing under window resizing is outside this feature.

Statuses: Implementation complete; verification inconclusive overall; work open; release not requested.

Next action and owner: Play the scene and try WASD and arrow keys, diagonals, release-to-stop, all four walls, and camera follow — user playtest.
