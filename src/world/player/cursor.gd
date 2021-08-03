extends Node2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var ui_cooldown := 0.1
var cell := Vector2.ZERO setget set_cell
onready var _sprite: AnimatedSprite = $AnimatedSprite
onready var _timer: Timer = $Timer
var board_position := Vector2(0, 0)
signal accept_pressed(cell)
signal cancel_pressed(cell)

func _ready() -> void:
	_timer.wait_time = ui_cooldown
	set_cell(grid.get_cell_coordinates(position))
	position = grid.get_map_position(cell)
	if not get_parent() is Viewport:
		board_position = get_parent().position

func set_cell(input: Vector2) -> void:
	var new_cell: Vector2 = grid.clamp_to_board(input)
	if new_cell.is_equal_approx(cell):
		return
	cell = new_cell
	position = grid.get_map_position(cell)

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if grid.is_within_bounds(grid.get_cell_coordinates(event.position-board_position)):
			self.cell = grid.get_cell_coordinates(event.position - board_position)
		if event.is_action_pressed("ui_accept") or event.is_action_pressed("left_click"):
			emit_signal("accept_pressed", cell)
			get_tree().set_input_as_handled()
		if event.is_action_pressed("ui_cancel") or event.is_action_pressed("right_click"):
			emit_signal("cancel_pressed", cell)
			get_tree().set_input_as_handled()
		var should_move = event.is_pressed()
		if event.is_echo():
			should_move = should_move and _timer.is_stopped()
		if not should_move:
			return
		if event.is_action("ui_right"):
			self.cell += Vector2.RIGHT
		elif event.is_action("ui_left"):
			self.cell += Vector2.LEFT
		if event.is_action("ui_up"):
			self.cell += Vector2.UP
		elif event.is_action("ui_down"):
			self.cell += Vector2.DOWN
