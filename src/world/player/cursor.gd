extends Node2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var ui_cooldown := 0.1
var cell := Vector2.ZERO setget set_cell
onready var _sprite: AnimatedSprite = $AnimatedSprite
onready var _timer: Timer = $Timer
onready var _validation_color := $validity
var board_position := Vector2(0, 0)
signal cursor_moved(cell)
signal accept_pressed(cell)
signal cancel_pressed(cell)

func _ready() -> void:
	_timer.wait_time = ui_cooldown
	set_cell(grid.get_cell_coordinates(position))
	position = grid.get_map_position(cell)
	set_color_mode(0)
	if not get_parent() is Viewport:
		board_position = get_parent().get_node("terrain").position

func set_cell(input: Vector2) -> void:
	var new_cell: Vector2 = grid.clamp_to_board(input)
	if new_cell.is_equal_approx(cell):
		return
	cell = new_cell
	position = grid.get_map_position(cell)

func set_color_mode(mode: int) -> void:
	match mode:
		0:
			_validation_color.visible = false
		1:
			_validation_color.visible = true
			_validation_color.color = Color(1,0,0,0.2)
		2:
			_validation_color.visible = true
			_validation_color.color = Color(0,1,0,0.2)

var past_cell := cell
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if grid.is_within_bounds(grid.get_cell_coordinates(event.position - board_position)):
			self.cell = grid.get_cell_coordinates(event.position - board_position)
			if cell != past_cell:
				emit_signal("cursor_moved", cell)
			past_cell = cell
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
		emit_signal("cursor_moved", cell)
	elif event.is_action("ui_left"):
		self.cell += Vector2.LEFT
		emit_signal("cursor_moved", cell)
	if event.is_action("ui_up"):
		self.cell += Vector2.UP
		emit_signal("cursor_moved", cell)
	elif event.is_action("ui_down"):
		self.cell += Vector2.DOWN
		emit_signal("cursor_moved", cell)
