extends Control

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var start_cell := Vector2(0, 0)
export var end_cell := Vector2(19, 10)
onready var terrain := $terrain
onready var path_display := $path_display
onready var player_cursor := $cursor
onready var ui_controls := $UI
onready var enemy_path := $enemy_path

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
var _astar := AStar2D.new()
var current_path := PoolVector2Array()

var build_mode := -1
var terrain_data = {
	-1: {"name": "empty", "move_cost": 0},
	0: {"name": "plains", "move_cost": 4},
	1: {"name": "forest", "move_cost": 8},
	2: {"name": "hills", "move_cost": 16},
	3: {"name": "road", "move_cost": 1},
	4: {"name": "gen", "move_cost": 16},
	5: {"name": "mg", "move_cost": 16},
	6: {"name": "vul", "move_cost": 16},
	7: {"name": "art", "move_cost": 16},
	8: {"name": "rkt", "move_cost": 16},
}
var points := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ui_controls.connect("build_mode", self, "_on_build_mode_changed") != OK:
		push_error("build mode signal connect fail")
	if player_cursor.connect("accept_pressed", self, "_on_player_accept") != OK:
		push_error("player accept signal connect fail")
	if player_cursor.connect("cancel_pressed", self, "_on_player_cancel") != OK:
		push_error("player cancel signal connect fail")
	if player_cursor.connect("cursor_moved", self, "_on_cursor_moved") != OK:
		push_error("player move signal connect fail")
	for x in 20:
		for y in 12:
			points.append(Vector2(x, y))
	initialize_path(points)
	path_display.draw_path(current_path)

func initialize_path(walkable_cells: Array) -> void:
	enemy_path.curve.clear_points()
	var cell_mappings := {}
	for cell in walkable_cells:
		cell_mappings[cell] = grid.as_index(cell)
	_add_and_connect_points(cell_mappings)
	current_path = calculate_point_path(start_cell, end_cell)
	for point in current_path:
		enemy_path.curve.add_point(grid.get_map_position(point))

func get_terrain_move_cost(cell) -> float:
	return terrain_data[terrain.get_cellv(cell)]["move_cost"]

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

func _on_build_mode_changed(new_mode) -> void:
	if new_mode in [0,1,2,3,4,5,6,7,8]:
		print("build mode changed to ", terrain_data[new_mode]["name"])
	build_mode = new_mode

func _on_cursor_moved(cell) -> void:
	if build_mode in [4,5,6,7,8]:
		if terrain.get_cellv(cell) == 0:
			player_cursor.set_color_mode(2)
		else:
			player_cursor.set_color_mode(1)
	elif build_mode == 9:
		if terrain.get_cellv(cell) in [4,5,6,7,8]:
			player_cursor.set_color_mode(2)
		else:
			player_cursor.set_color_mode(1)
	else:
		player_cursor.set_color_mode(0)

func _on_player_accept(cell) -> void:
	print("player pressed accept at ", cell)
	if build_mode != -1:
		if build_mode in [4,5,6,7,8]:
			if terrain.get_cellv(cell) != 0:
				print("cannot build tower except on plain")
				return
			else:
				terrain.build_tower(cell, build_mode)
		elif build_mode == 9:
			if not terrain.get_cellv(cell) in [4,5,6,7,8]:
				print("no tower to demolish")
				return
			else:
				terrain.remove_tower(cell)
		if build_mode in [0,1,2,3,4,5,6,7,8]:
			terrain.set_cellv(cell, build_mode)
		else:
			terrain.set_cellv(cell, 0)
		terrain.update_bitmask_region()
		initialize_path(points)
		path_display.draw_path(current_path)

func _on_player_cancel(cell) -> void:
	print("player pressed cancel at ", cell)
	ui_controls.untoggle_terrain()
	ui_controls.untoggle_towers()
	build_mode = -1

var unit = preload("res://src/world/unit/unit.tscn")
func spawn_enemy_unit() -> void:
	var unit_instance = unit.instance()
	unit_instance.position = grid.get_map_position(start_cell)
	if unit_instance.connect("end_reached", self, "_on_unit_reaching_end") != OK:
		push_error("unit reaching end signal connect fail")
	enemy_path.add_child(unit_instance)
	unit_instance.walk()

var units_reached_end := 0
func _on_unit_reaching_end() -> void:
	units_reached_end += 1
	print("units reached end: ", units_reached_end)

# DEBUGGING
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_home"):
		print(current_path)
		spawn_enemy_unit()
