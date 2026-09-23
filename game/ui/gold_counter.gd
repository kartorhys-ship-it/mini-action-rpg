extends Label

@export var gold_component_path: NodePath


func _ready() -> void:
	var gold_component: Node = get_node_or_null(gold_component_path)
	if gold_component == null:
		push_warning("GoldCounter could not find its GoldComponent.")
		text = "GOLD: --"
		return

	gold_component.connect(&"gold_changed", _on_gold_changed)
	_on_gold_changed(int(gold_component.get("current_gold")))


func _on_gold_changed(current_gold: int) -> void:
	text = "GOLD: %d" % current_gold
