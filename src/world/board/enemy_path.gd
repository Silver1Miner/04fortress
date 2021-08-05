extends TileMap

export var grid: Resource = preload("res://src/world/board/Grid.tres")
var _pathfinder: PathFinder
var current_path := PoolVector2Array()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rect_start := Vector2(0,4)
	var rect_end := Vector2(39,24)
	var points := []
	for x in 40:
		for y in 25:
			points.append(Vector2(x, y))
	initialize(points)
	draw_path(rect_start, rect_end)

func initialize(walkable_cells: Array) -> void:
	_pathfinder = PathFinder.new(grid, walkable_cells)

func draw_path(cell_start: Vector2, cell_end: Vector2) -> void:
	clear()
	current_path = _pathfinder.calculate_point_path(cell_start, cell_end)
	for cell in current_path:
		set_cellv(cell, 0)
	update_bitmask_region()

func stop() -> void:
	_pathfinder = null
	clear()
