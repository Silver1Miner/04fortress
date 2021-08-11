class_name Tower
extends Node2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
var cell := Vector2.ZERO setget set_cell

func _ready() -> void:
	self.cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
