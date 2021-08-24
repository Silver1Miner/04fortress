extends TileMap

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export (PackedScene) var GTower = preload("res://src/world/tower/tower.tscn")
export (PackedScene) var MTower = preload("res://src/world/tower/guntower.tscn")
export (PackedScene) var VTower = preload("res://src/world/tower/vulcan.tscn")
export (PackedScene) var ATower = preload("res://src/world/tower/artillery.tscn")
export (PackedScene) var RTower = preload("res://src/world/tower/rockets.tscn")
export (PackedScene) var B = preload("res://src/world/tower/blu.tscn")
export (PackedScene) var R = preload("res://src/world/tower/red.tscn")

var towers = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_end_points(start_cell, end_cell) -> void:
	set_cellv(start_cell, 10)
	set_cellv(end_cell, 9)
	var blu_instance = B.instance()
	add_child(blu_instance)
	blu_instance.position = grid.get_map_position(start_cell)
	var red_instance = R.instance()
	add_child(red_instance)
	red_instance.position = grid.get_map_position(end_cell)

func build_tower(cell, type) -> void:
	var tower_instance
	match type:
		4: # Generator
			tower_instance = GTower.instance()
		5: # MG
			tower_instance = MTower.instance()
		6: # Vulcan
			tower_instance = VTower.instance()
		7: # Artillery
			tower_instance = ATower.instance()
		8: # Rockets
			tower_instance = RTower.instance()
	towers[cell] = tower_instance
	add_child(tower_instance)
	tower_instance.position = grid.get_map_position(cell)

func remove_tower(cell) -> void:
	towers[cell].queue_free()
	towers[cell] = null
