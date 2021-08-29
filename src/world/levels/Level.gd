extends Node
class_name Level

var level_number := 1
onready var board = $board
onready var ui = $board/UI
onready var textbox = $board/UI/textbox
var next_level_path = "res://src/world/levels/Level2.tscn"
var level_over := false
var middle_dialogue_number := 0

var wave_schedule := {
	1: "i,1,i,2,i",
}
var opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Welcome to the sandbox! Experiment against endless waves! Press Escape to open the quit menu."
	},
}
var middle_dialogue := {
	"0": {
		"name": "red",
		"text": "The coder must have made a mistake."
	}
}
var ending_dialogue := {
	"0": {
		"name": "red",
		"text": "What the...? How did you beat the sandbox? The coder must have made a mistake."
	}
}

func _ready() -> void:
	override()
	board.wave_schedule = wave_schedule
	if board.connect("wave_started", self, "_on_wave_started") != OK:
		push_error("wave start signal connect fail")
	if board.connect("wave_finished", self, "_on_wave_finished") != OK:
		push_error("wave finish signal connect fail")
	if board.connect("level_finished", self, "_on_level_finished") != OK:
		push_error("level finish signal connect fail")
	if textbox.connect("text_finished", self, "_on_text_finished") != OK:
		push_error("text finish signal connect fail")
	textbox.initialize(opening_dialogue)
	#ui.update_level("Level " + str(level_number))

func override() -> void:
	# overwritten by inherited scenes
	pass

func _on_wave_started(_wave_number) -> void:
	# overwritten by inherited scenes
	pass

func _on_wave_finished(wave_number) -> void:
	if wave_number == middle_dialogue_number:
		textbox.initialize(middle_dialogue)
	Music.play_track(0)

func _on_level_finished() -> void:
	if PlayerData.sandbox:
		return
	PlayerData.completed_levels[level_number - 1] = 1
	PlayerData.save_state()
	level_over = true
	textbox.initialize(ending_dialogue)

func _on_text_finished() -> void:
	if level_over:
		go_to_next_level()

func go_to_next_level() -> void:
	if PlayerData.sandbox:
		return
	if get_tree().change_scene(next_level_path) != OK:
		push_error("fail to go to next level")
