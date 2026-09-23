extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var boss: CharacterBody2D = main_scene.get_node("BossSlime") as CharacterBody2D
	var normal_slime: CharacterBody2D = main_scene.get_node("Slime") as CharacterBody2D
	root.add_child(main_scene)
	await physics_frame
	await physics_frame

	var boss_health: Node = boss.get_node("HealthComponent")
	var boss_health_label: Label = boss.get_node("HealthLabel") as Label
	var victory_label: Label = main_scene.get_node("CanvasLayer/VictoryLabel") as Label
	if not is_equal_approx(float(boss_health.get("maximum_health")), 300.0):
		push_error("Boss should have 300 maximum health.")
		quit(1)
		return
	if float(boss.get("movement_speed")) <= float(normal_slime.get("movement_speed")):
		push_error("Boss movement speed should exceed the normal slime's speed.")
		quit(1)
		return
	if float(boss.get("contact_damage")) <= float(normal_slime.get("contact_damage")):
		push_error("Boss contact damage should exceed the normal slime's damage.")
		quit(1)
		return
	if boss_health_label.text != "LARGE SLIME  300 / 300" or victory_label.visible:
		push_error("Boss health should be labeled and victory hidden before the encounter ends.")
		quit(1)
		return
	if not boss.global_position.is_equal_approx(Vector2(810.0, 270.0)):
		push_error("Boss should wait in the Boss Room until the player approaches.")
		quit(1)
		return

	normal_slime.set_physics_process(false)
	(normal_slime.get_node("ContactArea") as Area2D).monitoring = false
	player.global_position = Vector2(650.0, 270.0)
	player.force_update_transform()
	await physics_frame
	await physics_frame
	await create_timer(1.1).timeout
	if boss.global_position.x >= 700.0:
		push_error("Boss should pursue through the aligned doorway into the Slime Den.")
		quit(1)
		return
	player.global_position = Vector2(150.0, 270.0)
	player.force_update_transform()
	await create_timer(4.2).timeout
	if boss.global_position.x >= 300.0 or absf(boss.global_position.y - 270.0) > 12.0:
		push_error("Boss should keep aggro and follow the doorway centerline into the Entry room.")
		quit(1)
		return
	player.call("receive_healing", 20.0)

	boss.set_physics_process(false)
	(boss.get_node("ContactArea") as Area2D).monitoring = false
	boss.global_position = Vector2(810.0, 270.0)
	boss.force_update_transform()
	player.global_position = Vector2(760.0, 270.0)
	player.force_update_transform()
	player.call("receive_healing", 100.0)
	boss.set_physics_process(true)
	(boss.get_node("ContactArea") as Area2D).monitoring = true
	await physics_frame
	await physics_frame
	await create_timer(0.35).timeout
	var player_health: Node = player.get_node("HealthComponent")
	if not is_equal_approx(float(player_health.get("current_health")), 80.0):
		push_error("Boss contact should deal 20 damage when it reaches the player; health is %.1f." % float(player_health.get("current_health")))
		quit(1)
		return

	boss.set_physics_process(false)
	(boss.get_node("ContactArea") as Area2D).monitoring = false
	player.call("receive_healing", 20.0)

	var attack_area: Area2D = player.get_node("AttackArea") as Area2D
	attack_area.position = Vector2.RIGHT * 24.0
	for hit_index: int in range(12):
		player.call("_start_attack")
		await create_timer(0.85).timeout
		if hit_index == 0 and not is_equal_approx(float(boss_health.get("current_health")), 275.0):
			push_error("One sword hit should reduce boss health by 25.")
			quit(1)
			return

	await process_frame
	if not bool(boss.get("_is_dead")) or boss_health_label.text != "BOSS DEFEATED":
		push_error("Defeating the boss should stop it and show BOSS DEFEATED.")
		quit(1)
		return
	if (boss.get_node("ContactArea") as Area2D).monitoring:
		push_error("A defeated boss must stop monitoring/contact attacking the player.")
		quit(1)
		return
	if not victory_label.visible or victory_label.text != "YOU WIN":
		push_error("Boss defeat should show the YOU WIN message.")
		quit(1)
		return
	if not main_scene.get_tree().paused:
		push_error("Boss defeat should pause the game so the player can no longer move or attack.")
		quit(1)
		return
	if main_scene.get_node_or_null("GoldPickup") != null:
		push_error("Boss should not drop gold; only the normal slime has the guaranteed drop.")
		quit(1)
		return

	print("Boss test passed: stats, persistent pursuit through both doorways, contact damage, sword defeat, and paused YOU WIN state.")
	quit(0)
