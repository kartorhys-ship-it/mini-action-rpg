extends Node2D

const ROOM_SIZE: Vector2 = Vector2(960.0, 540.0)
const FLOOR_COLOR: Color = Color(0.12, 0.14, 0.17, 1.0)
const BORDER_COLOR: Color = Color(0.35, 0.39, 0.43, 1.0)
const GRID_COLOR: Color = Color(0.17, 0.19, 0.22, 1.0)
const GRID_SPACING: float = 48.0


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, ROOM_SIZE), FLOOR_COLOR, true)
	draw_rect(Rect2(Vector2(20.0, 20.0), ROOM_SIZE - Vector2(40.0, 40.0)), BORDER_COLOR, false, 8.0)

	var x: float = 48.0
	while x < ROOM_SIZE.x:
		draw_line(Vector2(x, 24.0), Vector2(x, ROOM_SIZE.y - 24.0), GRID_COLOR, 1.0)
		x += GRID_SPACING

	var y: float = 48.0
	while y < ROOM_SIZE.y:
		draw_line(Vector2(24.0, y), Vector2(ROOM_SIZE.x - 24.0, y), GRID_COLOR, 1.0)
		y += GRID_SPACING
