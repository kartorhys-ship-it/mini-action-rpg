extends Area2D

@export_range(1.0, 100.0, 1.0) var heal_amount: float = 30.0

var _consumed: bool = false


func _on_body_entered(body: Node2D) -> void:
	if _consumed or not body.has_method("receive_healing"):
		return

	var healed: bool = bool(body.call(&"receive_healing", heal_amount))
	if not healed:
		return

	_consumed = true
	queue_free()
