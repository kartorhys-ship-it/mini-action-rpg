extends StaticBody2D

@onready var _health_component: Node = $HealthComponent
@onready var _health_label: Label = $HealthLabel
@onready var _dummy_art: Node2D = $DummyArt


func _ready() -> void:
	_health_component.connect(&"health_changed", _on_health_changed)
	_health_component.connect(&"died", _on_died)
	_on_health_changed(
		float(_health_component.get("current_health")),
		float(_health_component.get("maximum_health"))
	)


func receive_damage(amount: float) -> void:
	_health_component.call(&"take_damage", amount)


func _on_health_changed(current_health: float, maximum_health: float) -> void:
	_health_label.text = "DUMMY  %d / %d" % [roundi(current_health), roundi(maximum_health)]


func _on_died() -> void:
	_dummy_art.modulate = Color(0.42, 0.42, 0.42, 1.0)
	_health_label.text = "DUMMY DOWN"
