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
	var walls: StaticBody2D = main_scene.get_node("Walls") as StaticBody2D
	var camera: Camera2D = player.get_node("Camera2D") as Camera2D
	if not player.global_position.is_equal_approx(Vector2(150.0, 270.0)):
		push_error("Player should start in the entry chamber; got %s." % str(player.global_position))
		quit(1)
		return
	if camera.limit_left != 0 or camera.limit_top != 0 or camera.limit_right != 960 or camera.limit_bottom != 540:
		push_error("Camera limits should frame the complete 960 x 540 level.")
		quit(1)
		return
	for wall_name: String in ["EntryNorthPartition", "EntrySouthPartition", "BossNorthPartition", "BossSouthPartition"]:
		if walls.get_node_or_null(wall_name) == null:
			push_error("Dungeon partition '%s' is missing collision." % wall_name)
			quit(1)
			return

	player.global_position = Vector2(260.0, 190.0)
	player.force_update_transform()
	Input.action_press(&"move_right")
	await create_timer(0.5).timeout
	Input.action_release(&"move_right")
	if player.global_position.x >= 282.0:
		push_error("The entry partition should block movement through its solid section; player x=%.1f." % player.global_position.x)
		quit(1)
		return

	player.global_position = Vector2(260.0, 270.0)
	player.force_update_transform()
	await physics_frame
	Input.action_press(&"move_right")
	await create_timer(0.6).timeout
	Input.action_release(&"move_right")
	if player.global_position.x <= 330.0:
		push_error("The centerline doorway should allow passage into the slime den; player x=%.1f." % player.global_position.x)
		quit(1)
		return

	player.global_position = Vector2(660.0, 270.0)
	player.force_update_transform()
	await physics_frame
	Input.action_press(&"move_right")
	await create_timer(0.45).timeout
	Input.action_release(&"move_right")
	if player.global_position.x <= 710.0:
		push_error("The second centerline doorway should allow passage into the boss-room placeholder; player x=%.1f." % player.global_position.x)
		quit(1)
		return

	print("Dungeon layout test passed: spawn, full-level camera framing, solid partition, and both doorways.")
	quit(0)
