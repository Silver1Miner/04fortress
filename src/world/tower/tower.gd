class_name Tower
extends Node2D

export var is_hitscan := true
export var attack_cooldown := 1.0
export var attack_radius := 32
export var attack_damage := 4
export var tower_value := 1000

export var grid: Resource = preload("res://src/world/board/Grid.tres")
export (PackedScene) var Bullet = preload("res://src/world/tower/bullet.tscn")
var cell := Vector2.ZERO setget set_cell
onready var _sprite: Sprite = $Sprite
onready var _attack_range: Area2D = $attack_zone
onready var _hit_radius := $attack_zone/CollisionShape2D
onready var _cooldown_timer: Timer = $Timer
onready var _ray = $RayCast2D
onready var _shot_effect = $shot_flash
onready var _laser_sight = $Line2D
onready var _shoot_sound = $AudioStreamPlayer

func _ready() -> void:
	add_to_group("towers")
	_laser_sight.add_point(Vector2.ZERO)
	_laser_sight.add_point(Vector2.ZERO)
	self.cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)
	_hit_radius.shape.set_radius(attack_radius)

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func _draw() -> void:
	var center = grid.get_map_position(cell) - Vector2(8,8)
	var radius = attack_radius
	var color = Color(1.0, 0, 0)
	draw_circle_arc(center, radius, 0, 360, color)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func _physics_process(_delta: float) -> void:
	var targets: Array = _attack_range.get_overlapping_areas()
	if targets.empty():
		_laser_sight.points[1] = Vector2.ZERO
		return
	#var target: Node2D = targets[0]
	var target
	for t in targets:
		if t.get_parent().is_in_group("enemy"):
			target = t
			break
	if target != null:
		_laser_sight.points[1] = target.global_position - position
		aim_at(target.global_position)
		if _cooldown_timer.is_stopped():
			shoot_at(target)
	else:
		_laser_sight.points[1] = Vector2.ZERO

func shoot_at(target: Node2D) -> void:
	_shot_effect.frame = 0
	_shot_effect.play()
	_shoot_sound.play()
	if is_hitscan:
		if target.get_parent().has_method("take_damage_bullet"):
			target.get_parent().take_damage_bullet(attack_damage)
	else:
		var bullet_instance = Bullet.instance()
		get_parent().get_parent().get_node("enemy_path").add_child(bullet_instance)
		bullet_instance.position = get_global_position()
		bullet_instance.rotation = _ray.cast_to.angle()
		bullet_instance.damage = attack_damage
	_cooldown_timer.start(attack_cooldown)

var _cardinal_direction_last
func aim_at(target_position: Vector2) -> void:
	var motion = target_position - position
	_ray.cast_to = motion
	var _cardinal_direction = int(4.0 * (motion.rotated(PI/4.0).angle() + PI) / TAU)
	if _cardinal_direction != _cardinal_direction_last:
		_sprite.frame = (3 - _cardinal_direction)
		match _cardinal_direction:
			0: # left
				_shot_effect.position = Vector2(-12, -4)
				_shot_effect.rotation_degrees = 90
			1: # up
				_shot_effect.position = Vector2(0, -15)
				_shot_effect.rotation_degrees = 180
			2: # right
				_shot_effect.position = Vector2(12, -4)
				_shot_effect.rotation_degrees = 270
			3: # down
				_shot_effect.position = Vector2(0, 2)
				_shot_effect.rotation_degrees = 0
	_cardinal_direction_last = _cardinal_direction
