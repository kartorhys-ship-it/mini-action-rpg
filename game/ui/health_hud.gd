extends Control

@export var health_component_path: NodePath

@onready var _health_label: Label = $HealthLabel
@onready var _health_bar: ProgressBar = $HealthBar
var _fill_style: StyleBoxFlat


func _ready() -> void:
	_setup_bar_style()
	var health_component: Node = get_node_or_null(health_component_path)
	if health_component == null:
		push_warning("HealthHud could not find its HealthComponent.")
		_health_label.text = "HP: -- / --"
		_health_bar.value = 0.0
		return

	health_component.connect(&"health_changed", _on_health_changed)
	_on_health_changed(
		float(health_component.get("current_health")),
		float(health_component.get("maximum_health"))
	)


func _setup_bar_style() -> void:
	var background_style: StyleBoxFlat = StyleBoxFlat.new()
	background_style.bg_color = Color(0.08, 0.1, 0.12, 0.95)
	background_style.set_corner_radius_all(4)
	background_style.set_border_width_all(2)
	background_style.border_color = Color(0.86, 0.9, 0.92, 1.0)
	_health_bar.add_theme_stylebox_override(&"background", background_style)

	_fill_style = StyleBoxFlat.new()
	_fill_style.bg_color = Color(0.2, 0.82, 0.36, 1.0)
	_fill_style.set_corner_radius_all(3)
	_health_bar.add_theme_stylebox_override(&"fill", _fill_style)


func _on_health_changed(current_health: float, maximum_health: float) -> void:
	_health_label.text = "HP: %d / %d" % [roundi(current_health), roundi(maximum_health)]
	_health_bar.max_value = maximum_health
	_health_bar.value = current_health
	var health_ratio: float = current_health / maximum_health
	if health_ratio <= 0.3:
		_fill_style.bg_color = Color(0.9, 0.18, 0.16, 1.0)
	elif health_ratio <= 0.6:
		_fill_style.bg_color = Color(0.95, 0.68, 0.12, 1.0)
	else:
		_fill_style.bg_color = Color(0.2, 0.82, 0.36, 1.0)
