extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	root.add_child(main_scene)
	await physics_frame

	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var player_health: Node = player.get_node("HealthComponent")
	var health_label: Label = main_scene.get_node("CanvasLayer/HealthHud/HealthLabel") as Label
	var game_over_label: Label = main_scene.get_node("CanvasLayer/GameOverLabel") as Label
	var victory_label: Label = main_scene.get_node("CanvasLayer/VictoryLabel") as Label
	if game_over_label.visible or victory_label.visible:
		push_error("Neither end-state label should be visible at the start of the run.")
		quit(1)
		return

	player.call("receive_damage", 100.0)
	if not bool(player_health.get("is_dead")) or not is_equal_approx(float(player_health.get("current_health")), 0.0):
		push_error("Lethal damage should set the player's health to zero and mark it dead.")
		quit(1)
		return
	if not game_over_label.visible or game_over_label.text != "GAME OVER":
		push_error("Player defeat should display the GAME OVER message.")
		quit(1)
		return
	if health_label.text != "HP: 0 / 100":
		push_error("The health HUD should remain visible at zero health.")
		quit(1)
		return
	if not main_scene.get_tree().paused or player.is_physics_processing():
		push_error("Player defeat should pause gameplay and stop player physics processing.")
		quit(1)
		return
	if victory_label.visible:
		push_error("Player defeat must not show the boss victory label.")
		quit(1)
		return

	print("Game-over test passed: lethal damage showed GAME OVER, retained the zero-health HUD, and paused the run.")
	quit(0)
