extends Node2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var start_cell := Vector2(0, 0)
export var end_cell := Vector2(19, 10)
onready var terrain := $terrain
onready var enemy_path := $enemy_path
onready var player_cursor := $cursor
onready var ui_controls := $UI

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
var _astar := AStar2D.new()

var current_path := PoolVector2Array()

#signal terrain_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ui_controls.connect("build_mode", self, "_on_build_mode_changed") != OK:
		push_error("build mode signal connect fail")
	var points := []
	for x in 20:
		for y in 12:
			points.append(Vector2(x, y))
	initialize_path(points)
	enemy_path.draw_path(current_path)

func initialize_path(walkable_cells: Array) -> void:
	var cell_mappings := {}
	for cell in walkable_cells:
		cell_mappings[cell] = grid.as_index(cell)
	_add_and_connect_points(cell_mappings)
	current_path = calculate_point_path(start_cell, end_cell)

func get_terrain_move_cost(cell) -> float:
	return terrain_data[terrain.get_cellv(cell)]["move_cost"]

var terrain_data = {
	-1: {"name": "empty", "move_cost": 0},
	0: {"name": "plains", "move_cost": 2},
	1: {"name": "forest", "move_cost": 3},
	2: {"name": "hills", "move_cost": 4},
	3: {"name": "road", "move_cost": 1},
	4: {"name": "barrier", "move_cost": 5}
}

func _add_and_connect_points(cell_mappings: Dictionary) -> void:
	for point in cell_mappings:
		_astar.add_point(cell_mappings[point], point, get_terrain_move_cost(point))
	for point in cell_mappings:
		for neighbor_index in _find_neighbor_indices(point, cell_mappings):
			_astar.connect_points(cell_mappings[point], neighbor_index)

func _find_neighbor_indices(cell: Vector2, cell_mappings: Dictionary) -> Array:
	var out := []
	for direction in DIRECTIONS:
		var neighbor: Vector2 = cell + direction
		if not cell_mappings.has(neighbor):
			continue
		if not _astar.are_points_connected(cell_mappings[cell], cell_mappings[neighbor]):
			out.push_back(cell_mappings[neighbor])
	return out

func calculate_point_path(start: Vector2, end: Vector2) -> PoolVector2Array:
	var start_index: int = grid.as_index(start)
	var end_index: int = grid.as_index(end)
	if _astar.has_point(start_index) and _astar.has_point(end_index):
		return _astar.get_point_path(start_index, end_index)
	else:
		return PoolVector2Array()

# DEBUGGING
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		var cell = grid.get_cell_coordinates(event.position - position)
		print(terrain_data[terrain.get_cellv(cell)]["name"])
	if event.is_action_pressed("ui_home"):
		print(current_path)
