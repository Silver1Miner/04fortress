extends TileMap

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export (PackedScene) var GTower = preload("res://src/world/tower/tower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func build_tower(cell) -> void:
	var tower_instance = GTower.instance()
	add_child(tower_instance)
	tower_instance.position = grid.get_map_position(cell)
