extends CharacterBody2D

@export var target_path: NodePath
@export_range(1.0, 1000.0, 1.0) var movement_speed: float = 90.0
@export_range(1.0, 1000.0, 1.0) var detection_range: float = 180.0
@export_range(0.0, 200.0, 1.0) var stopping_distance: float = 38.0
@export var gold_drop_scene: PackedScene

var _target: CharacterBody2D
var _is_dead: bool = false

@onready var _health_component: Node = $HealthComponent
@onready var _health_label: Label = $HealthLabel
@onready var _slime_art: Node2D = $SlimeArt


func _ready() -> void:
	var target_node: Node = get_node_or_null(target_path)
	if target_node is CharacterBody2D:
		_target = target_node

	_health_component.connect(&"health_changed", _on_health_changed)
	_health_component.connect(&"died", _on_died)
	_on_health_changed(
		float(_health_component.get("current_health")),
		float(_health_component.get("maximum_health"))
	)


func _physics_process(_delta: float) -> void:
	if _is_dead or not is_instance_valid(_target):
		velocity = Vector2.ZERO
		return

	var offset_to_target: Vector2 = _target.global_position - global_position
	var distance_to_target: float = offset_to_target.length()
	if distance_to_target > detection_range or distance_to_target <= stopping_distance:
		velocity = Vector2.ZERO
	else:
		velocity = offset_to_target.normalized() * movement_speed
	move_and_slide()


func receive_damage(amount: float) -> void:
	_health_component.call(&"take_damage", amount)


func _on_health_changed(current_health: float, maximum_health: float) -> void:
	_health_label.text = "SLIME  %d / %d" % [roundi(current_health), roundi(maximum_health)]


func _on_died() -> void:
	_is_dead = true
	velocity = Vector2.ZERO
	collision_layer = 0
	_slime_art.modulate = Color(0.42, 0.42, 0.42, 1.0)
	_health_label.text = "SLIME DOWN"
	call_deferred("_spawn_gold_drop")


func _spawn_gold_drop() -> void:
	if gold_drop_scene == null:
		push_warning("Slime has no GoldPickup scene configured; no gold was dropped.")
		return

	var pickup: Node2D = gold_drop_scene.instantiate() as Node2D
	if pickup == null:
		push_warning("Slime GoldPickup scene root must inherit Node2D.")
		return

	var world_parent: Node = get_parent()
	world_parent.add_child(pickup)
	pickup.global_position = global_position
