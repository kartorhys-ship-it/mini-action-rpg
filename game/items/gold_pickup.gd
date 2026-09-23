extends Area2D

@export_range(1, 999, 1) var gold_amount: int = 1

var _collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if _collected or not body.has_method("collect_gold"):
		return

	_collected = true
	body.call(&"collect_gold", gold_amount)
	queue_free()
