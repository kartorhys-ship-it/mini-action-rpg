extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var slime: CharacterBody2D = main_scene.get_node("Slime") as CharacterBody2D
	var boss: CharacterBody2D = main_scene.get_node("BossSlime") as CharacterBody2D
	boss.set_physics_process(false)
	(boss.get_node("ContactArea") as Area2D).monitoring = false
	player.position = Vector2(620.0, 270.0)
	slime.position = Vector2(650.0, 270.0)
	root.add_child(main_scene)
	await physics_frame
	await physics_frame

	var player_health: Node = player.get_node("HealthComponent")
	var current_health: float = float(player_health.get("current_health"))
	if not is_equal_approx(current_health, 90.0):
		push_error("Entering slime contact should deal 10 immediate damage; got %.1f health." % current_health)
		quit(1)
		return

	await create_timer(0.45).timeout
	if not is_equal_approx(float(player_health.get("current_health")), 90.0):
		push_error("The slime must not hit again before its one-second contact interval.")
		quit(1)
		return

	await create_timer(0.7).timeout
	if not is_equal_approx(float(player_health.get("current_health")), 80.0):
		push_error("Staying in contact for one interval should apply exactly one more 10-point hit.")
		quit(1)
		return

	player.global_position = Vector2(820.0, 270.0)
	player.force_update_transform()
	await physics_frame
	await physics_frame
	var health_after_leaving: float = float(player_health.get("current_health"))
	await create_timer(1.1).timeout
	if not is_equal_approx(float(player_health.get("current_health")), health_after_leaving):
		push_error("The slime should not damage the player outside its contact area.")
		quit(1)
		return

	slime.call("receive_damage", 30.0)
	await process_frame
	var health_after_defeat: float = float(player_health.get("current_health"))
	await create_timer(1.1).timeout
	if not is_equal_approx(float(player_health.get("current_health")), health_after_defeat):
		push_error("A defeated slime should not deal further damage.")
		quit(1)
		return

	print("Enemy combat test passed: contact hit, one-second cadence, range exit, and defeated-state checks.")
	quit(0)
