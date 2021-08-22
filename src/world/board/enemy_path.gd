extends Path2D

signal unit_damage(damage)
signal unit_destroyed(bounty)
signal unit_count(number_in_wave)
onready var timer = $Timer
export var grid: Resource = preload("res://src/world/board/Grid.tres")
var schedule := []
var i := 0
var start_cell

func _ready() -> void:
	if timer.connect("timeout", self, "_on_timer_timeout") != OK:
		push_error("timer connect fail")

func spawn_wave(wave_schedule: String, start) -> void:
	schedule = wave_schedule.split(",")
	start_cell = start
	var number_in_wave = 0
	for s in schedule:
		if s in ["i","a","m","s"]:
			number_in_wave += 1
	emit_signal("unit_count", number_in_wave)
	check_wave_ended()
	if schedule[i] in ["i","a","m","s"]:
		spawn_enemy_unit(start_cell, schedule[i])
		i += 1
	check_wave_ended()
	if schedule[i].is_valid_float():
		timer.wait_time = float(schedule[i])
		i += 1
		timer.start()

func _on_timer_timeout() -> void:
	check_wave_ended()
	if schedule[i] in ["i","a","m","s"]:
		spawn_enemy_unit(start_cell, schedule[i])
		i += 1
	check_wave_ended()
	if schedule[i].is_valid_float():
		timer.wait_time = float(schedule[i])
		i += 1
		timer.start()

func check_wave_ended() -> void:
	if i >= len(schedule):
		print("wave spawning finished")
		i = 0
		return

var unit = preload("res://src/world/unit/unit.tscn")
var infantry = preload("res://src/world/unit/infantry.tscn")
var antitank = preload("res://src/world/unit/antitank.tscn")
var mech = preload("res://src/world/unit/mechanized.tscn")
var scout = preload("res://src/world/unit/scout.tscn")
func spawn_enemy_unit(start, type) -> void:
	var unit_instance
	match type:
		"i":
			unit_instance = infantry.instance()
		"a":
			unit_instance = antitank.instance()
		"m":
			unit_instance = mech.instance()
		"s":
			unit_instance = scout.instance()
	unit_instance.position = grid.get_map_position(start)
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
