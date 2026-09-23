# Game Over

## Purpose

Make player defeat clear and freeze the run when health reaches zero.

## Behavior

- Main observes the player's HealthComponent `died` signal.
- Player defeat reveals a centered `GAME OVER` message and pauses gameplay.
- The player HUD continues to show zero health while the scene is paused.
- No movement, attacks, enemy actions, or pickups continue after defeat.

## Ownership and boundaries

- HealthComponent remains the owner of health and death state.
- The Player keeps its existing local death response (stop movement and disable attack).
- Main owns the run-level game-over label and pauses the scene tree in response to player death.
- The CanvasLayer remains visible during pause so the message and HUD can be read.

## Must not

- Add restart, respawn, scene transition, game-over sound/effects, or persistent save state.
- Change damage, healing, enemy AI, boss victory, or item behavior.
- Add an Autoload or a general game-state framework.
