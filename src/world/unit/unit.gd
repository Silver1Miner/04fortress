tool
class_name Unit
extends Path2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var move_speed := 600 # pixels per second
export var max_hp := 15
var _is_walking := false setget _set_is_walking
onready var hp := max_hp setget set_hp
onready var _path_follow: PathFollow2D = $PathFollow2D
onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _sprite: Sprite = $PathFollow2D/Sprite
var cell := Vector2.ZERO setget set_cell

func _ready() -> void:
	set_process(false)
	set_physics_process(true)
	self.cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)
	if not Engine.editor_hint:
		curve = Curve2D.new()

func _process(delta: float) -> void:
	_path_follow.offset += move_speed * delta
	if _path_follow.unit_offset >= 1.0:
		self._is_walking = false
		_path_follow.offset = 0.0
		position = grid.get_map_position(cell)
		curve.clear_points()
		print("walk_finished")

func set_hp(new_hp) -> void:
	hp = new_hp

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func walk_along(path: PoolVector2Array) -> void:
	if path.empty():
		return
	curve.add_point(Vector2.ZERO)
	for point in path:
		curve.add_point(grid.get_map_position(point) - position)
	cell = path[-1]
	_set_is_walking(true)

func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)

var _position_last_frame := Vector2()
var _cardinal_direction := 0
var _cardinal_direction_last_frame := 0
func _physics_process(_delta: float) -> void:
	var motion = _sprite.position - _position_last_frame
	if motion.length() > 0.001:
		_cardinal_direction = int(4.0 * (motion.rotated(PI/4.0).angle() + PI) / TAU)
	if _cardinal_direction != _cardinal_direction_last_frame:
		match _cardinal_direction:
			0:
				_sprite.set_flip_h(true)
				_animation_player.play("walk_left")
			1:
				_animation_player.play("walk_up")
			2: # right
				_sprite.set_flip_h(true)
				_animation_player.play("walk_left")
			3:
				_animation_player.play("walk_down")
	_position_last_frame = _sprite.position
	_cardinal_direction_last_frame = _cardinal_direction

# DEBUGGING
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		_sprite.set_flip_h(false)
		_animation_player.play("walk_left")
	elif event.is_action_pressed("ui_right"):
		_sprite.set_flip_h(true)
		_animation_player.play("walk_left")
	elif event.is_action_pressed("ui_up"):
		_animation_player.play("walk_up")
	elif event.is_action_pressed("ui_down"):
		_animation_player.play("walk_down")

func test_walk() -> void:
	var points := [Vector2(2, 2), Vector2(2, 5), Vector2(9, 5), Vector2(8, 7)]
	walk_along(PoolVector2Array(points))
