class_name Unit
extends PathFollow2D

export (PackedScene) var Explosion = preload("res://src/world/effects/explosion.tscn")
export (PackedScene) var FCT = preload("res://src/world/effects/FCT.tscn")
export var grid: Resource = preload("res://src/world/board/Grid.tres")
export var move_speed := 20 # pixels per second
export var max_hp := 20
export var bounty := 500
export var plain_speed := 20
export var forest_speed := 10
export var barrier_speed := 5
export var road_speed := 25
var _is_walking := false setget _set_is_walking
onready var hp := max_hp setget set_hp
onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _sprite: Sprite = $Sprite
onready var _hp_bar: TextureProgress = $TextureProgress
var cell := Vector2.ZERO setget set_cell
var terrain = null
var invulnerable := false
export var bullet_resistance := false

signal unit_destroyed(bounty)
signal end_reached(hp)

func _ready() -> void:
	add_to_group("enemy")
	set_process(false)
	self.cell = grid.get_cell_coordinates(position)
	position = grid.get_map_position(cell)
	_hp_bar.max_value = max_hp
	_hp_bar.value = max_hp
	terrain = get_parent().get_parent().get_node("terrain")

var _last_cell := cell
var _position_last_frame := Vector2()
var _cardinal_direction := 0
var _cardinal_direction_last_frame := 0
func _process(delta: float) -> void:
	offset += move_speed * delta
	if grid.get_cell_coordinates(position) != _last_cell:
		_last_cell = grid.get_cell_coordinates(position)
		var current_terrain = terrain.get_cellv(grid.get_cell_coordinates(position))
		# 0 plains, 1 forest, 2 hills, 3 road, 4-8 towers
		if current_terrain == 2:
			move_speed = barrier_speed
		elif current_terrain in [0,4,5,6,7,8,9,10]:
			move_speed = plain_speed
		elif current_terrain == 1:
			move_speed = forest_speed
		elif current_terrain == 3:
			move_speed = road_speed
	if unit_offset >= 1.0:
		self._is_walking = false
		#_path_follow.offset = 0.0
		emit_signal("end_reached", hp)
		#print("walk finished")
		queue_free()
	var motion = position - _position_last_frame
	if motion.length() > 0.01:
		_cardinal_direction = int(4.0 * (motion.rotated(PI/4.0).angle() + PI) / TAU)
	if _cardinal_direction != _cardinal_direction_last_frame:
		match _cardinal_direction:
			0:
				_sprite.set_flip_h(false)
				_animation_player.play("walk_left")
			1:
				_animation_player.play("walk_up")
			2:
				_sprite.set_flip_h(true)
				_animation_player.play("walk_left")
			3:
				_animation_player.play("walk_down")
	_position_last_frame = position
	_cardinal_direction_last_frame = _cardinal_direction

func take_damage_bullet(damage_amount) -> void:
	if bullet_resistance:
		damage_amount = ceil(clamp(damage_amount/2,0,damage_amount))
	take_damage(damage_amount)

func take_damage(damage_amount) -> void:
	if invulnerable:
		return
	var current_terrain = terrain.get_cellv(grid.get_cell_coordinates(position))
	# 0 plains, 1 forest, 2 hills, 3 road, 4-8 towers
	if current_terrain in [1, 2]:
		damage_amount = ceil(clamp(damage_amount/2,0,damage_amount))
	$damage_flash.frame = 0
	$damage_flash.play()
	var fct = FCT.instance()
	get_parent().get_node("effects").add_child(fct)
	fct.rect_position = get_global_position() + Vector2(0,-16)
	fct.show_value(str(damage_amount), Vector2(0,-8), 1, PI/2)
	set_hp(clamp(hp - damage_amount, 0, max_hp))

func set_hp(new_hp) -> void:
	hp = new_hp
	_hp_bar.value = hp
	if hp <= 0:
		invulnerable = true
		var fct = FCT.instance()
		get_parent().get_node("effects").add_child(fct)
		fct.rect_position = get_global_position()
		fct.show_value("+$" + str(bounty), Vector2(0,-8), 1, PI/2, true, Color(0,1,0))
		create_explosion()
		_animation_player.stop()
		emit_signal("unit_destroyed", bounty)
		queue_free()

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func create_explosion() -> void:
	var explosion_instance = Explosion.instance()
	get_parent().add_child(explosion_instance)
	explosion_instance.position = get_global_position()

func walk() -> void:
	_set_is_walking(true)

func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)

# DEBUGGING
#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_left"):
#		_sprite.set_flip_h(false)
#		_animation_player.play("walk_left")
#	elif event.is_action_pressed("ui_right"):
#		_sprite.set_flip_h(true)
#		_animation_player.play("walk_left")
#	elif event.is_action_pressed("ui_up"):
#		_animation_player.play("walk_up")
#	elif event.is_action_pressed("ui_down"):
#		_animation_player.play("walk_down")
