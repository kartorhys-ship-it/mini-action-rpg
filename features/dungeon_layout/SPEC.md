# Dungeon Layout

## Purpose

Turn the flat test room into a readable mini-dungeon with a clear entrance, combat space, and destination for later boss work.

## Behavior

- Keep the dungeon within the existing 960 × 540 world and visible viewport.
- Divide it into three connected areas: Entry, Slime Den, and Boss Room (a placeholder with no boss encounter yet).
- Use physical partition walls with aligned, wide doorways so the player and slime can travel through the level centerline.
- Keep the outer boundary walls and add collision to every interior partition.
- Place the player in Entry, the training dummy in Entry, and the slime and health potion in Slime Den.
- Keep the gold and health HUDs fixed on screen while the world remains framed.

## Ownership and boundaries

- `main.gd` owns floor colors, room markings, and readable room labels.
- `main.tscn` owns spawn positions, camera limits, and all outer/interior wall collision.
- Existing player, combat, enemy, item, and HUD scenes keep their behavior.

## Must not

- Add a boss, locked doors, room transitions, keys, procedural layout, additional enemies, or new items.
- Resize the world or viewport, add camera transitions, or change combat tuning.
- Break the clear horizontal path between the entry, slime den, and boss-room placeholder.
