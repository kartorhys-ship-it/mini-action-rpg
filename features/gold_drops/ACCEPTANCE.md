# Acceptance — Gold Drops and Counter

- [x] The gold counter displays `GOLD: 0` at scene start.
- [x] A defeated slime creates exactly one visible coin worth 1 gold at its defeat position.
- [x] The coin is not collected before the player touches it.
- [x] Touching the coin adds exactly 1 to player gold and removes the coin.
- [x] The counter updates from `GOLD: 0` to `GOLD: 1` when collected.
- [x] Repeated death/damage handling cannot create duplicate coins.
- [ ] Training dummy behavior and the player's health HUD scope remain unchanged.
- [x] Gold, slime, and training-dummy automated integration tests pass.
- [ ] Godot editor import and runtime checks pass.
- [ ] The user confirms coin visibility and collection in the graphical game.
- [ ] No persistent economy, spending, or unrelated item system was added.
