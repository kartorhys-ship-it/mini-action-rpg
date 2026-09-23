extends CharacterBody2D

@export_range(1.0, 1000.0, 1.0) var movement_speed: float = 220.0
@export_range(0.1, 2.0, 0.05) var attack_duration: float = 0.16
@export_range(0.1, 3.0, 0.05) var attack_cooldown: float = 0.75
@export_range(0.0, 100.0, 1.0) var attack_damage: float = 25.0
@export_range(0.2, 2.0, 0.05) var attack_visual_duration: float = 0.7

var facing_direction: Vector2 = Vector2.DOWN
var _attack_ready: bool = true
var _hit_targets: Array[Node] = []

@onready var _attack_area: Area2D = $AttackArea
@onready var _attack_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var _attack_visual: Polygon2D = $AttackArea/AttackVisual


func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	if not input_direction.is_zero_approx():
		facing_direction = input_direction.normalized()
		_attack_area.position = facing_direction * 24.0
		_attack_area.rotation = facing_direction.angle() + PI / 2.0
	velocity = input_direction * movement_speed
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		_start_attack()


func _start_attack() -> void:
	if not _attack_ready:
		return
	_attack_ready = false
	_hit_targets.clear()
	_attack_shape.set_deferred("disabled", false)
	_attack_area.set_deferred("monitoring", true)
	_attack_visual.visible = true
	_attack_area.force_update_transform()
	await get_tree().physics_frame
	for target: Node in _attack_area.get_overlapping_bodies():
		_hit_target(target)
	await get_tree().create_timer(attack_duration).timeout
	_attack_shape.set_deferred("disabled", true)
	_attack_area.set_deferred("monitoring", false)
	await get_tree().create_timer(maxf(0.0, attack_visual_duration - attack_duration)).timeout
	_attack_visual.visible = false
	await get_tree().create_timer(maxf(0.0, attack_cooldown - attack_visual_duration)).timeout
	_attack_ready = true


func _on_attack_area_body_entered(body: Node2D) -> void:
	if not _attack_ready and not _attack_shape.disabled:
		_hit_target(body)


func _hit_target(target: Node) -> void:
	if target in _hit_targets:
		return
	if not target.has_method("receive_damage"):
		return
	_hit_targets.append(target)
	target.call("receive_damage", attack_damage)


func _on_health_component_died() -> void:
	velocity = Vector2.ZERO
	set_physics_process(false)
	_attack_area.set_deferred("monitoring", false)
	_attack_shape.set_deferred("disabled", true)
	_attack_visual.visible = false
