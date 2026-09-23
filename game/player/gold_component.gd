extends Node

signal gold_changed(current_gold: int)

var current_gold: int = 0


func add_gold(amount: int) -> void:
	if amount <= 0:
		return

	current_gold += amount
	gold_changed.emit(current_gold)
