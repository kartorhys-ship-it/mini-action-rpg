# Tests

Place deterministic gameplay tests here as features are implemented.

Human playtesting remains required for feel, pacing, feedback, and usability.

Run the training-dummy integration test from the project root with:

```powershell
.\run-godot.ps1 --headless --script res://tests/test_training_dummy.gd
```

Run the Slime AI integration test with:

```powershell
.\run-godot.ps1 --headless --script res://tests/test_slime_ai.gd
```

Run the gold drop and collection integration test with:

```powershell
.\run-godot.ps1 --headless --script res://tests/test_gold_drops.gd
```

Run the enemy contact-damage integration test with:

```powershell
.\run-godot.ps1 --headless --script res://tests/test_enemy_combat.gd
```

Run the health HUD integration test with:

```powershell
.\run-godot.ps1 --headless --script res://tests/test_health_hud.gd
```
