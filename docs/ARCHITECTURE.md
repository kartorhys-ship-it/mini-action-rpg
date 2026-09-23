# Architecture

## Guiding approach

The project uses small, composable Godot scenes and scripts. Gameplay behavior belongs to the relevant scene or component, while independent systems communicate through signals.

The architecture is deliberately modest for V0.1. It should be easy to understand before it becomes easy to extend.

## Planned high-level layout

```text
GAME
├── Player (`CharacterBody2D`)
│   ├── Movement behavior (`game/player/player.gd`, implemented)
│   ├── HealthComponent (`game/player/health_component.gd`, implemented)
│   └── Sword attack behavior (`game/player/player.gd`, implemented)
├── Enemies
│   ├── TrainingDummy (`game/enemies/training_dummy.tscn`, stationary combat test target)
│   ├── Slime (`game/enemies/slime.tscn`, implemented direct pursuit)
│   ├── HealthComponent
│   ├── MovementComponent
│   ├── CombatComponent
│   └── EnemyAI
├── World
│   ├── Main scene
│   ├── Dungeon layout
│   └── Spawn locations
├── Items
│   ├── GoldPickup
│   └── HealthPotion
├── UI
│   ├── Health bar
│   └── Gold counter
└── Systems
    └── Game state and scene flow, only where needed
```

## Communication boundaries

Health owns health values and emits signals such as:

```text
health_changed(current, maximum)
died
```

The HUD observes those signals. Combat requests damage through a health component interface. The HUD does not modify health directly.

Enemy death emits or triggers a drop request. The player collects pickups through their collision/interaction boundary. Gold changes are observed by the gold counter.

## Data and behavior

Behavior belongs in scripts. Tunable values such as movement speed, health, damage, attack cooldown, and drop value should move into typed exported properties or Resources when the feature needs reusable configuration.

Do not create a data framework before a feature requires one.

## Global state

Avoid Autoloads during the early milestones. Use direct scene references, signals, and parent-child ownership first. A global system may be introduced only when its lifetime and responsibility are genuinely project-wide and the decision is documented.

## Scene ownership

- The main scene owns the current level and top-level game flow.
- The player node owns player-local behavior. Keep a simple behavior on its script until a real reuse need justifies extracting a component.
- The player owns its HealthComponent; health values stay in that component and interested systems observe its signals.
- The player owns its attack area. It detects targets on collision layer 4 and calls their public `receive_damage(amount)` method once per swing; targets own their own health.
- Enemy scenes own enemy-local components and AI.
- The training dummy is a static body on physics layer 4. It owns a HealthComponent and displays its health by observing `health_changed`; the player's attack calls its public `receive_damage(amount)` method.
- The slime uses a scene-supplied NodePath to the player and direct distance-based pursuit, stops at a separation, and uses the same HealthComponent and damage-receiver contract. Contact damage is owned by the later Enemy Combat milestone.
- The HUD observes the player and game-state signals.
- Pickups own their collection behavior and notify the relevant gameplay system.

## Constraints for AI-assisted changes

- Work within one feature boundary per task.
- Inspect existing scenes and scripts before editing.
- Prefer additive, local changes.
- Do not replace an existing working system with a new pattern without explaining the reason.
- Keep architecture documentation current when ownership or communication boundaries change.
