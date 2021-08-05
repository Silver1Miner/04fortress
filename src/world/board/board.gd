extends TileMap

export var start_cell := Vector2(0, 5)
export var end_cell := Vector2(39, 8)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_bitmask_region()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
