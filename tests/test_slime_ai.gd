extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	root.add_child(main_scene)
	await physics_frame
	await physics_frame

	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var slime: CharacterBody2D = main_scene.get_node("Slime") as CharacterBody2D
	var health_component: Node = slime.get_node("HealthComponent")
	var health_label: Label = slime.get_node("HealthLabel") as Label

	slime.global_position = Vector2(700.0, 270.0)
	var outside_position: Vector2 = slime.global_position
	await create_timer(0.2).timeout
	if not slime.global_position.is_equal_approx(outside_position):
		push_error("The slime should remain still while the player is outside detection range.")
		quit(1)
		return

	player.global_position = Vector2(620.0, 270.0)
	await create_timer(0.75).timeout
	var distance_to_player: float = slime.global_position.distance_to(player.global_position)
	if slime.global_position.x >= outside_position.x:
		push_error("The slime should move toward the player after they enter detection range.")
		quit(1)
		return
	if distance_to_player < 38.0 or distance_to_player > 44.0:
		push_error("The slime should stop near its configured separation; actual distance %.1f." % distance_to_player)
		quit(1)
		return

	var attack_area: Area2D = player.get_node("AttackArea") as Area2D
	attack_area.position = Vector2.RIGHT * 24.0
	player.call("_start_attack")
	await create_timer(0.9).timeout
	var current_health: float = float(health_component.get("current_health"))
	if not is_equal_approx(current_health, 5.0) or health_label.text != "SLIME  5 / 30":
		push_error("One sword swing should reduce slime health from 30 to 5; got %.1f and '%s'." % [current_health, health_label.text])
		quit(1)
		return

	player.call("_start_attack")
	await create_timer(0.9).timeout
	if health_label.text != "SLIME DOWN":
		push_error("A second sword swing should defeat the slime and show SLIME DOWN.")
		quit(1)
		return

	print("Slime AI test passed: aggro range, approach/stop distance, two-hit defeat, and health feedback.")
	quit(0)
