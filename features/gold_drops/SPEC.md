# Gold Drops and Counter

## Purpose

Reward defeating a slime with a visible, collectible coin and show the player's current gold.

## Behavior

- A slime drops exactly one coin worth 1 gold when it is defeated.
- The coin appears at the slime's defeat position and remains until collected.
- The player collects the coin by touching it; collection adds its value to the player's gold total and removes the coin.
- The on-screen gold counter starts at 0 and updates when the player's gold total changes.
- Non-positive gold additions and pickup values have no effect.

## Ownership and boundaries

- The slime creates the pickup on its existing `died` signal.
- The GoldPickup owns its visible coin, collision area, and one-time collection behavior.
- The player owns a GoldComponent and exposes `collect_gold(amount)` as the pickup receiver contract.
- The GoldComponent owns the total and emits `gold_changed(current_gold)`; the GoldCounter observes that signal.
- No Autoload or global currency manager is added.

## Must not

- Add gold persistence, spending, inventories, shops, random drop rates, or drops for other entities.
- Add the player's health HUD, health potion, or unrelated combat behavior.
