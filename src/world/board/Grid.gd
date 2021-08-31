class_name Grid
extends Resource

export var board_size := Vector2(25, 15)
export var cell_size := Vector2(16, 16)
var _half_cell_size = cell_size /2

func get_map_position(cell_coordinates: Vector2) -> Vector2:
	return cell_coordinates * cell_size + _half_cell_size

func get_cell_coordinates(map_position: Vector2) -> Vector2:
	return (map_position / cell_size).floor()

func is_within_bounds(cell_coordinates: Vector2) -> bool:
	var out := (cell_coordinates.x >= 0 and cell_coordinates.x < board_size.x)
	return (out and cell_coordinates.y >= 0 and cell_coordinates.y < board_size.y)

func clamp_to_board(grid_position: Vector2) -> Vector2:
	var out := grid_position
	out.x = clamp(out.x, 0, board_size.x - 1.0)
	out.y = clamp(out.y, 0, board_size.y - 1.0)
	return out

func as_index(cell: Vector2) -> int:
	return int(cell.x + board_size.x * cell.y)
