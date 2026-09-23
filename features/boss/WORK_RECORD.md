# Boss — Large Slime

Outcome: Complete the small dungeon's combat loop with a stronger boss and a clear win message.

Mode / rigor: Feature change, standard. This is the capstone encounter combining enemy scene reuse, combat tuning, health/death behavior, room placement, and game-state feedback.

Current behavior before this change: The player could defeat the boss, but dragging it around the partition corner could make it stick, and the player could still control the character after the win message appeared.

Scope and boundaries: One 300-health Large Slime, stronger/faster contact behavior, existing Space sword combat, doorway-centered cross-room pursuit with persistent aggro, defeated feedback, and a `YOU WIN` overlay that pauses gameplay. No phases, projectiles, restart, or game-over flow.

Acceptance: See [SPEC.md](SPEC.md) and [ACCEPTANCE.md](ACCEPTANCE.md).

Implementation: Complete in [boss_slime.tscn](../../game/enemies/boss_slime.tscn), reusing [slime.gd](../../game/enemies/slime.gd) with 300 HP, 120 px/s movement, 160 px detection, and 20 contact damage every 1.5 seconds. Its art and collision are enlarged and recolored. The boss retains aggro after initial detection and uses the dungeon's room boundaries and doorway centerline as pursuit waypoints. Main connects its health component's `died` signal to the `YOU WIN` label and pauses the scene tree on victory. It has no gold drop.

Verification:

| Criterion | Check and conditions | Result | Evidence / limitation |
|---|---|---|---|
| Boss stats, persistent pursuit through two doorways, contact hit, sword damage, defeat, and paused win state | `run-godot.ps1 --headless --script res://tests/test_boss.gd` | passed | Test verifies cross-room chase into Entry along the doorway centerline, 20-point boss contact, 25-point sword hits, death feedback, visible `YOU WIN`, and paused gameplay after twelve hits. |
| Normal slime/gold and existing gameplay | Boss, dungeon, health potion/HUD, enemy combat, slime, gold, and dummy integration tests | passed | All eight integration test scripts pass. |
| Project imports and runs | Godot 4.7.2 `--headless --editor --quit` and `--headless --quit-after 120` | passed | Both exited 0; the known non-blocking Windows root certificate-store warning persists. |
| Diff formatting | `git diff --check` | passed | Exit 0; only line-ending conversion notices. |
| Boss presentation, pursuit, and victory readability | User plays graphical game | passed | User confirmed the boss encounter behaved correctly after the doorway pursuit and victory-pause fix. |

Human explanation: pending. Walk through inherited boss tuning, shared health/attack contracts, and Main's win-signal handling.

Limitations and unknowns: This is a single-contact-attack boss without phases, special moves, or restart flow. Difficulty and visual scale need user playtesting.

Statuses: Implementation complete; automated and graphical verification passed; human explanation pending; work open; release not requested.

Next action and owner: Assistant: implement the next roadmap slice, player game-over flow. Human explanation remains available as a learning follow-up.
