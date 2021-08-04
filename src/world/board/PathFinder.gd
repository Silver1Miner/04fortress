class_name PathFinder
extends Path2D

var grid: Resource = preload("res://src/world/board/Grid.tres")
var _astar := AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.editor_hint:
		curve = Curve2D.new()
	find_path()

func find_path() -> void:
	var points := [Vector2(2,2),Vector2(2,5),Vector2(8,5),Vector2(8,7)]
	for point in points:
		curve.add_point(grid.get_map_position(point))
