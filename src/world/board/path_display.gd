extends TileMap

func _ready() -> void:
	if PlayerData.invisible_path:
		visible = false

func draw_path(current_path) -> void:
	clear()
	for cell in current_path:
		set_cellv(cell, 0)
	update_bitmask_region()
