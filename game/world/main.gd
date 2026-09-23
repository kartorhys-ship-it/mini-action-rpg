extends Node2D

const ROOM_SIZE: Vector2 = Vector2(960.0, 540.0)
const FLOOR_COLOR: Color = Color(0.12, 0.14, 0.17, 1.0)
const BORDER_COLOR: Color = Color(0.35, 0.39, 0.43, 1.0)
const GRID_COLOR: Color = Color(0.17, 0.19, 0.22, 1.0)
const ENTRY_COLOR: Color = Color(0.12, 0.15, 0.18, 1.0)
const SLIME_DEN_COLOR: Color = Color(0.14, 0.16, 0.17, 1.0)
const BOSS_ROOM_COLOR: Color = Color(0.13, 0.14, 0.18, 1.0)
const ROOM_LABEL_COLOR: Color = Color(0.78, 0.82, 0.84, 1.0)
const DOORWAY_COLOR: Color = Color(0.62, 0.53, 0.31, 1.0)
const GRID_SPACING: float = 48.0


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, ROOM_SIZE), FLOOR_COLOR, true)
	draw_rect(Rect2(Vector2(32.0, 44.0), Vector2(260.0, 452.0)), ENTRY_COLOR, true)
	draw_rect(Rect2(Vector2(308.0, 44.0), Vector2(374.0, 452.0)), SLIME_DEN_COLOR, true)
	draw_rect(Rect2(Vector2(698.0, 44.0), Vector2(230.0, 452.0)), BOSS_ROOM_COLOR, true)

	var x: float = 48.0
	while x < ROOM_SIZE.x:
		draw_line(Vector2(x, 24.0), Vector2(x, ROOM_SIZE.y - 24.0), GRID_COLOR, 1.0)
		x += GRID_SPACING

	var y: float = 48.0
	while y < ROOM_SIZE.y:
		draw_line(Vector2(24.0, y), Vector2(ROOM_SIZE.x - 24.0, y), GRID_COLOR, 1.0)
		y += GRID_SPACING

	draw_rect(Rect2(Vector2(20.0, 20.0), ROOM_SIZE - Vector2(40.0, 40.0)), BORDER_COLOR, false, 8.0)
	draw_rect(Rect2(Vector2(292.0, 44.0), Vector2(16.0, 180.0)), BORDER_COLOR, true)
	draw_rect(Rect2(Vector2(292.0, 316.0), Vector2(16.0, 180.0)), BORDER_COLOR, true)
	draw_rect(Rect2(Vector2(682.0, 44.0), Vector2(16.0, 180.0)), BORDER_COLOR, true)
	draw_rect(Rect2(Vector2(682.0, 316.0), Vector2(16.0, 180.0)), BORDER_COLOR, true)
	draw_line(Vector2(292.0, 224.0), Vector2(308.0, 224.0), DOORWAY_COLOR, 3.0)
	draw_line(Vector2(292.0, 316.0), Vector2(308.0, 316.0), DOORWAY_COLOR, 3.0)
	draw_line(Vector2(682.0, 224.0), Vector2(698.0, 224.0), DOORWAY_COLOR, 3.0)
	draw_line(Vector2(682.0, 316.0), Vector2(698.0, 316.0), DOORWAY_COLOR, 3.0)

	var room_font: Font = ThemeDB.fallback_font
	draw_string(room_font, Vector2(126.0, 82.0), "ENTRY", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 16, ROOM_LABEL_COLOR)
	draw_string(room_font, Vector2(443.0, 82.0), "SLIME DEN", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 16, ROOM_LABEL_COLOR)
	draw_string(room_font, Vector2(750.0, 82.0), "BOSS ROOM", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 16, ROOM_LABEL_COLOR)
	draw_string(room_font, Vector2(770.0, 106.0), "COMING SOON", HORIZONTAL_ALIGNMENT_LEFT, -1.0, 12, ROOM_LABEL_COLOR)
