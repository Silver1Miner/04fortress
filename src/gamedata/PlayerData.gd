extends Node

var current_level := 1
var sandbox := true
var game_over := false
var completed_levels = [1, 0, 0, 0]

func _ready():
	load_state()

func reset() -> void:
	completed_levels = [1, 0, 0, 0]
	save_state()

func load_state() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://terra.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://terra.save", File.READ)
	completed_levels = parse_json(save_game.get_line())
	save_game.close()

func save_state() -> void:
	var save_game = File.new()
	save_game.open("user://terra.save", File.WRITE)
	save_game.store_line(to_json(completed_levels))
	save_game.close()
