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
	var dummy: StaticBody2D = main_scene.get_node("TrainingDummy") as StaticBody2D
	var health_component: Node = dummy.get_node("HealthComponent")
	var health_label: Label = dummy.get_node("HealthLabel") as Label

	player.call("_start_attack")
	await create_timer(0.9).timeout

	var current_health: float = float(health_component.get("current_health"))
	if not is_equal_approx(current_health, 75.0):
		push_error("Expected one sword hit to leave the dummy at 75 health; got %.1f." % current_health)
		quit(1)
		return
	if health_label.text != "DUMMY  75 / 100":
		push_error("Expected the dummy health label to show 75 / 100; got '%s'." % health_label.text)
		quit(1)
		return

	dummy.call("receive_damage", 100.0)
	if health_label.text != "DUMMY DOWN":
		push_error("Expected the defeated dummy to remain visible and show DUMMY DOWN.")
		quit(1)
		return

	print("Training dummy test passed: one sword swing caused one 25-point hit, and defeat feedback updated.")
	quit(0)
