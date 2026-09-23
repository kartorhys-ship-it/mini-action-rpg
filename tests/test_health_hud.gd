extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	root.add_child(main_scene)
	await process_frame

	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var health_component: Node = player.get_node("HealthComponent")
	var health_hud: Control = main_scene.get_node("CanvasLayer/HealthHud") as Control
	var health_label: Label = health_hud.get_node("HealthLabel") as Label
	var health_bar: ProgressBar = health_hud.get_node("HealthBar") as ProgressBar
	if health_label.text != "HP: 100 / 100" or not is_equal_approx(health_bar.value, 100.0):
		push_error("Health HUD should initialize with full player health.")
		quit(1)
		return

	player.call("receive_damage", 10.0)
	if health_label.text != "HP: 90 / 100" or not is_equal_approx(health_bar.value, 90.0):
		push_error("Health HUD should update to 90 after ten damage.")
		quit(1)
		return

	player.call("receive_damage", 90.0)
	if health_label.text != "HP: 0 / 100" or not is_zero_approx(health_bar.value):
		push_error("Health HUD should show zero health when the player dies.")
		quit(1)
		return
	if not bool(health_component.get("is_dead")):
		push_error("Health HUD must observe health; the HealthComponent should still own death state.")
		quit(1)
		return

	print("Health HUD test passed: full health, damage update, and zero-health display.")
	quit(0)
