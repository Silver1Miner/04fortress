extends Level

var new_level_number := 4
var new_middle_dialogue_number := 3
var new_next_level_path := "res://src/menu/MainMenu.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i,1,i,4,i,1,i,1,i,1,i",
	2: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
	3: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
	4: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Well, this is level 4, the last level."
	},
}
var new_middle_dialogue := {
	"0": {
		"name": "red",
		"text": "We're halfway through level 4."
	},
}
var new_ending_dialogue := {
	"0": {
		"name": "red",
		"text": "We did it!"
	}
}

func override() -> void:
	level_number = new_level_number
	next_level_path = new_next_level_path
	wave_schedule = new_wave_schedule
	opening_dialogue = new_opening_dialogue
	middle_dialogue = new_middle_dialogue
	ending_dialogue = new_ending_dialogue
	middle_dialogue_number = new_middle_dialogue_number
