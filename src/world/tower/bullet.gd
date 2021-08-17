extends Node2D

export var speed := 50 # pixels/sec
export var timer := 1.0
export var damage := 10
export (PackedScene) var Explosion = preload("res://src/world/effects/explosion.tscn")
onready var _timer := $Timer
onready var _attack_range = $blast
var target_position := Vector2.ZERO

func _ready() -> void:
	_timer.wait_time = timer
	_timer.start()

func _physics_process(delta: float) -> void:
	position += Vector2(cos(rotation), sin(rotation)) * speed * delta

func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("enemy"):
		explode()

func _on_Timer_timeout() -> void:
	explode()

func explode() -> void:
	var targets: Array = _attack_range.get_overlapping_areas()
	var explosion_instance = Explosion.instance()
	get_parent().add_child(explosion_instance)
	explosion_instance.position = get_global_position()
	explosion_instance.scale = Vector2(0.5, 0.5)
	for t in targets:
		if t.get_parent().is_in_group("enemy"):
			if t.get_parent().has_method("take_damage"):
				t.get_parent().take_damage(damage)
	queue_free()
