# Mini Action RPG — Game Design

## Genre

2D top-down action RPG.

## Goal

Reach the end of a small dungeon and defeat the boss.

## Player

- WASD movement.
- Eight-direction movement.
- Space: basic sword attack (current project binding).
- 100 maximum health.
- Health potion restores 30 health.
- The player dies when health reaches zero.

## Normal enemy: Slime

- 30 health.
- Detects the player at short range.
- Chases the player.
- Performs a simple contact or melee attack.
- Drops gold when defeated.

## Boss: Large Slime

- 300 health.
- Faster movement than a normal slime.
- Stronger attack than a normal slime.
- Defeating the boss completes the game.

## World

One small dungeon level with:

- A player start area.
- A few rooms or combat spaces.
- Collision boundaries and walls.
- Normal enemy spawn locations.
- A boss room.

## Items

- Gold drop: increases the player's gold count when collected.
- Health potion: restores 30 health and disappears when collected.

## UI

- Player health bar.
- Gold counter.
- Game-over message.
- Victory message.

## Win condition

The boss is defeated.

## Lose condition

The player's health reaches zero.

## Explicit non-goals for V0.1

- No inventory screen.
- No equipment system.
- No quests or dialogue.
- No crafting.
- No procedural generation.
- No multiplayer.
- No advanced pathfinding.
- No multiple weapons or enemy types.
