# Player Movement

Outcome: Move the player around the existing dungeon with keyboard controls while the room walls constrain movement.

Mode / rigor: Feature change, standard. It introduces user-visible gameplay behavior, input configuration, physics movement, and interaction with existing collision boundaries.

Current behavior: The player is a `CharacterBody2D` in `game/world/main.tscn`, with collision mask 1; dungeon walls are `StaticBody2D` on layer 1. No movement script or input map actions exist yet.

Scope and boundaries: Add keyboard movement to the existing player, preserve its placeholder and camera, normalize diagonal input, and use the existing walls. Health, combat, enemies, items, and HUD are excluded.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Not started. The specifications exist; no movement code has been added.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Keyboard movement, eight directions, normalized speed, stop behavior | Play the scene with keyboard input and compare cardinal/diagonal travel over equal time | not run | Implementation has not started. |
| Wall collision and camera behavior | Move into each wall and observe player/camera framing | not run | Implementation has not started; visual playtest is required. |
| No startup parser/runtime errors | Run the project with Godot after implementation | not run | Implementation has not started. |

Human explanation: pending. After implementation, explain input-to-velocity-to-physics flow, wall collision ownership, and the limitation of available checks.

Limitations and unknowns: The exact movement speed is intentionally left for implementation as a named, exported value and should be playtested. Camera framing under window resizing is not specified by the current feature contract.

Statuses: Implementation not started; verification pending; work open; release not requested.

Next action and owner: Implement the bounded movement feature after reviewing the plan — assistant, with user playtest.
