extends Path2D

signal unit_damage(damage)
signal unit_destroyed(bounty)
export var grid: Resource = preload("res://src/world/board/Grid.tres")

func spawn_wave(wave_schedule: String, start_cell) -> void:
	var schedule = wave_schedule.split("/")
	for s in schedule:
		if s == "u":
			spawn_enemy_unit(start_cell)
		elif s.is_valid_float():
			var time = float(s)
			yield(get_tree().create_timer(time), "timeout")
	print("wave spawn finished")

var unit = preload("res://src/world/unit/unit.tscn")
func spawn_enemy_unit(start_cell) -> void:
	var unit_instance = unit.instance()
	unit_instance.position = grid.get_map_position(start_cell)
	if unit_instance.connect("end_reached", self, "_on_unit_reaching_end") != OK:
		push_error("unit reaching end signal connect fail")
	if unit_instance.connect("unit_destroyed", self, "_on_unit_destroyed") != OK:
		push_error("unit destroyed signal connect fail")
	add_child(unit_instance)
	unit_instance.walk()

func _on_unit_reaching_end(damage) -> void:
	emit_signal("unit_damage", damage)

func _on_unit_destroyed(bounty) -> void:
	emit_signal("unit_destroyed", bounty)
