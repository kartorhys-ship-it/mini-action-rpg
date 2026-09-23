# Dungeon Layout

Outcome: Replace the flat room with a readable, connected entry, combat room, and future boss-room placeholder.

Mode / rigor: Feature change, standard. This changes the player-facing world geometry, collision, spawn layout, and camera framing while preserving existing combat/item systems.

Current behavior: A single enclosed 960 × 540 room has a full-screen grid, player start near the center, a dummy, slime, potion, and no interior walls or room identities.

Scope and boundaries: Three connected areas in one screen, interior collision partitions with broad aligned doorways, current entities redistributed, and camera limits. No boss or transitions.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [main.gd](../../game/world/main.gd) and [main.tscn](../../game/world/main.tscn). Three differently shaded/labeled rooms are drawn in the original 960 × 540 world. Four matching collision segments form two 92-pixel centerline doorways. The player and dummy start in Entry; slime and potion are in Slime Den. Camera limits preserve the full-level frame.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Solid partition blocks movement; both doorways allow passage; spawn/camera bounds | `run-godot.ps1 --headless --script res://tests/test_dungeon_layout.gd` | passed | Test used the mapped move action to collide with the first partition, then pass through both openings. |
| Existing gameplay and item features | Dungeon, health potion/HUD, enemy combat, slime, gold, and dummy integration tests | passed | All seven integration test scripts pass; slime chase across the right partition is covered by the slime test. |
| Editor import/runtime and diff | Godot 4.7.2 `--headless --editor --quit`, `--headless --quit-after 120`, and `git diff --check` | passed | All exit 0. The known non-blocking Windows root certificate-store warning persists. |
| Room labels, layout readability, and partition/door behavior | User graphical playtest | passed | User confirmed seeing all three room labels and that the partitions/doorways behaved as intended. |

Human explanation: pending. Walk through world drawing, collision segments, aligned passages, and camera bounds.

Limitations and unknowns: Boss Room is only a labeled destination placeholder. The simple slime follows a direct path and is only guaranteed to cross the aligned centerline route.

Statuses: Implementation complete; automated and graphical verification passed; human explanation pending; work open; release not requested.

Next action and owner: None. Verified layout was committed and pushed as `78ce2eb` (`feat: add connected dungeon rooms`).
