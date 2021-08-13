class_name Tower
extends Node2D

export var grid: Resource = preload("res://src/world/board/Grid.tres")
var cell := Vector2.ZERO setget set_cell
onready var _sprite = $Sprite
onready var _attack_range = $attack_zone
onready var _cooldown_timer = $Timer
onready var _ray = $RayCast2D

func _ready() -> void:
	self.cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func _physics_process(_delta: float) -> void:
	if not _cooldown_timer.is_stopped():
		return
	var targets: Array = _attack_range.get_overlapping_areas()
	if targets.empty():
		return
	var target: Node2D = targets[0]
	shoot_at(target.global_position)

var _cardinal_direction_last
func shoot_at(target_position: Vector2) -> void:
	var motion = target_position - position
	_ray.cast_to = motion
	var _cardinal_direction = int(4.0 * (motion.rotated(PI/4.0).angle() + PI) / TAU)
	if _cardinal_direction != _cardinal_direction_last:
		_sprite.frame = (3 - _cardinal_direction)
	_cardinal_direction_last = _cardinal_direction
