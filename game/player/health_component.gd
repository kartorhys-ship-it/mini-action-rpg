extends Node

signal health_changed(current_health: float, maximum_health: float)
signal died

@export_range(1.0, 10000.0, 1.0) var maximum_health: float = 100.0

var current_health: float = 0.0
var is_dead: bool = false


func _ready() -> void:
	current_health = maximum_health
	health_changed.emit(current_health, maximum_health)


func take_damage(amount: float) -> void:
	if is_dead or amount <= 0.0:
		return

	var previous_health: float = current_health
	current_health = maxf(current_health - amount, 0.0)
	if current_health == previous_health:
		return

	var reached_zero: bool = current_health <= 0.0
	if reached_zero:
		is_dead = true
	health_changed.emit(current_health, maximum_health)
	if reached_zero:
		died.emit()


func heal(amount: float) -> void:
	if is_dead or amount <= 0.0:
		return

	var previous_health: float = current_health
	current_health = minf(current_health + amount, maximum_health)
	if current_health != previous_health:
		health_changed.emit(current_health, maximum_health)
