# Roadmap

The game is built in vertical slices. Each milestone should launch, be checked, and be playtested before the next one begins.

## Phase 0 — Project foundation

- [x] Create the Godot project.
- [x] Establish `AGENTS.md` development rules.
- [x] Write the one-page game design.
- [x] Document the initial architecture.
- [x] Define the milestone roadmap.
- [x] Add Git hygiene.

## V0.1 — Complete playable loop

1. [ ] Main scene and empty world — implementation is in place; visual inspection and manual wall-collision playtest are pending (see `features/main_scene/WORK_RECORD.md`).
2. [ ] Player movement — implementation is in place; interactive movement, collision, and camera playtest pending (see `features/player_movement/WORK_RECORD.md`).
3. [ ] Player health — implementation is in place; damage/heal behavior and death signal checks are pending until there is a caller (see `features/player_health/WORK_RECORD.md`).
4. [ ] Basic sword attack — implementation and headless launch checks are in place; facing, visual timing, and input need an interactive playtest (see `features/sword_attack/WORK_RECORD.md`).
5. [ ] Training dummy — implementation and automated sword-hit check passed; user visual playtest pending (see `features/training_dummy/WORK_RECORD.md`).
6. [ ] Slime AI — implementation and deterministic chase/defeat tests pass; live playtest pending (see `features/slime_ai/WORK_RECORD.md`).
7. [ ] Enemy combat — contact damage and automated checks implemented; live damage/readability playtest pending (see `features/enemy_combat/WORK_RECORD.md`).
8. [ ] Health HUD — implementation and integration test pass; graphical visibility check pending (see `features/health_hud/WORK_RECORD.md`).
9. [ ] Gold drops and gold counter — implementation and integration test pass; graphical playtest pending (see `features/gold_drops/WORK_RECORD.md`).
10. [ ] Health potion — implementation and integration tests pass; graphical visibility/pickup playtest pending (see `features/health_potion/WORK_RECORD.md`).
11. [x] Dungeon layout — implementation, automated checks, and user movement playtest passed (see `features/dungeon_layout/WORK_RECORD.md`).
12. [x] Boss — implementation, automated checks, and user boss-fight playtest passed (see `features/boss/WORK_RECORD.md`).
13. [x] Game-over flow — automated checks and user graphical playtest passed (see `features/game_over/WORK_RECORD.md`).
14. [x] Victory flow — boss defeat displays `YOU WIN` and pauses gameplay (see `features/boss/WORK_RECORD.md`).

## V0.2 — Feedback polish

- [ ] Animations.
- [ ] Sound effects.
- [ ] Particles.
- [ ] Better sprites.
- [ ] Screen shake.
- [ ] Damage feedback and numbers.
- [ ] UI polish.

## Later versions

- V0.3: multiple enemy types.
- V0.4: inventory and equipment.
- V0.5: experience, levels, and player stats.
- V0.6: NPCs, dialogue, and quests.

## Milestone completion rule

A milestone is complete only when:

1. Its acceptance criteria are satisfied.
2. Relevant automated checks pass.
3. The game launches without parser/runtime errors.
4. The feature has been manually playtested.
5. The Git diff has been reviewed.
6. The change is committed as one logical unit.
