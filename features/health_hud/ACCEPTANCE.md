# Acceptance — Health HUD

- [ ] At startup, the HUD shows `HP: 100 / 100` and a full bar.
- [ ] Each 10-point slime contact hit visibly changes the text and bar (100 → 90 → 80).
- [ ] The bar scales correctly for the HealthComponent's configured maximum health.
- [ ] At zero health, the HUD shows `HP: 0 / 100` and an empty bar while player controls stop.
- [x] The HUD observes health signals and does not mutate health.
- [x] Enemy contact, slime defeat, gold pickup, and training-dummy tests continue to pass.
- [x] Godot editor import and headless runtime checks pass.
- [ ] The user confirms the HUD is visible and tracks damage in the graphical game.
- [ ] No game-over, healing, potion, or unrelated UI system is added.
