extends SceneTree

const MAIN_SCENE: PackedScene = preload("res://game/world/main.tscn")
const HEALTH_POTION: PackedScene = preload("res://game/items/health_potion.tscn")


func _initialize() -> void:
	_run_test.call_deferred()


func _run_test() -> void:
	var main_scene: Node2D = MAIN_SCENE.instantiate() as Node2D
	root.add_child(main_scene)
	await physics_frame
	await physics_frame

	var player: CharacterBody2D = main_scene.get_node("Player") as CharacterBody2D
	var health_component: Node = player.get_node("HealthComponent")
	var health_label: Label = main_scene.get_node("CanvasLayer/HealthHud/HealthLabel") as Label
	var potion: Area2D = main_scene.get_node("HealthPotion") as Area2D

	player.global_position = potion.global_position
	player.force_update_transform()
	potion.force_update_transform()
	await physics_frame
	await physics_frame
	await process_frame
	if not is_instance_valid(potion) or not is_equal_approx(float(health_component.get("current_health")), 100.0):
		push_error("A potion touched at full health should remain available without changing health.")
		quit(1)
		return

	player.global_position = potion.global_position + Vector2(-60.0, 0.0)
	player.force_update_transform()
	await physics_frame
	await physics_frame
	player.call("receive_damage", 40.0)
	if not is_equal_approx(float(health_component.get("current_health")), 60.0):
		push_error("Test setup should reduce player health to 60 before pickup.")
		quit(1)
		return

	player.global_position = potion.global_position
	player.force_update_transform()
	potion.force_update_transform()
	await physics_frame
	await physics_frame
	await physics_frame
	await process_frame
	if not is_equal_approx(float(health_component.get("current_health")), 90.0):
		push_error("Collecting the potion should restore 30 health from 60; got %.1f." % float(health_component.get("current_health")))
		quit(1)
		return
	if health_label.text != "HP: 90 / 100":
		push_error("Health HUD should reflect potion healing; got '%s'." % health_label.text)
		quit(1)
		return
	if is_instance_valid(potion):
		push_error("A successfully used potion should be removed.")
		quit(1)
		return

	var capped_potion: Area2D = HEALTH_POTION.instantiate() as Area2D
	main_scene.add_child(capped_potion)
	capped_potion.global_position = player.global_position + Vector2(60.0, 0.0)
	capped_potion.force_update_transform()
	await physics_frame
	player.global_position = capped_potion.global_position
	player.force_update_transform()
	await physics_frame
	await physics_frame
	await process_frame
	if not is_equal_approx(float(health_component.get("current_health")), 100.0):
		push_error("Potion healing should clamp at maximum health; got %.1f." % float(health_component.get("current_health")))
		quit(1)
		return

	player.call("receive_damage", 100.0)
	var revived: bool = bool(player.call("receive_healing", 30.0))
	if revived or not bool(health_component.get("is_dead")) or not is_zero_approx(float(health_component.get("current_health"))):
		push_error("Healing must not revive a dead player.")
		quit(1)
		return

	print("Health potion test passed: full-health persistence, 30-point healing, HUD update, max clamp, and no revival.")
	quit(0)
