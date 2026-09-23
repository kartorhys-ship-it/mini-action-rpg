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
	var gold_component: Node = player.get_node("GoldComponent")
	var gold_counter: Label = main_scene.get_node("CanvasLayer/GoldCounter") as Label

	if gold_counter.text != "GOLD: 0":
		push_error("The gold counter should start at zero; got '%s'." % gold_counter.text)
		quit(1)
		return
	if main_scene.get_node_or_null("GoldPickup") != null:
		push_error("A gold pickup should not exist before the slime is defeated.")
		quit(1)
		return

	var defeat_position: Vector2 = slime.global_position
	slime.call("receive_damage", 30.0)
	await process_frame
	await process_frame

	var pickup: Area2D = main_scene.get_node_or_null("GoldPickup") as Area2D
	if pickup == null:
		push_error("Defeating the slime should create a GoldPickup.")
		quit(1)
		return
	if not pickup.global_position.is_equal_approx(defeat_position):
		push_error("The GoldPickup should appear at the slime's defeat position.")
		quit(1)
		return
	if int(pickup.get("gold_amount")) != 1:
		push_error("The normal slime should drop exactly one gold.")
		quit(1)
		return
	if int(gold_component.get("current_gold")) != 0:
		push_error("Gold should not be collected automatically when the slime dies.")
		quit(1)
		return

	slime.call("receive_damage", 1.0)
	await process_frame
	var drop_count: int = 0
	for child: Node in main_scene.get_children():
		if child is Area2D and child.name.begins_with("GoldPickup"):
			drop_count += 1
	if drop_count != 1:
		push_error("Repeated damage after death should not create duplicate drops; found %d." % drop_count)
		quit(1)
		return

	player.global_position = pickup.global_position
	player.force_update_transform()
	pickup.force_update_transform()
	await physics_frame
	await physics_frame
	await physics_frame
	if int(gold_component.get("current_gold")) != 1 or gold_counter.text != "GOLD: 1":
		push_error("Touching the coin should increment both player gold and the counter.")
		quit(1)
		return
	await process_frame
	if is_instance_valid(pickup):
		push_error("A collected GoldPickup should be removed from the scene.")
		quit(1)
		return

	print("Gold drop test passed: one coin spawned on slime death and added one gold on touch.")
	quit(0)
