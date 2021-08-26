extends Level

var new_level_number := 3
var new_middle_dialogue_number := 0
var new_next_level_path := "res://src/world/levels/Level4.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i,1,i,4,i,1,i,1,i,1,i",
	2: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
	3: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
	4: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,2,i,1,i,1,i",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Level 3!"
	},
}
var new_middle_dialogue := {}
var new_ending_dialogue := {
	"0": {
		"name": "blu",
		"text": "No!"
	},
}

func override() -> void:
	level_number = new_level_number
	next_level_path = new_next_level_path
	wave_schedule = new_wave_schedule
	opening_dialogue = new_opening_dialogue
	middle_dialogue = new_middle_dialogue
	ending_dialogue = new_ending_dialogue
	middle_dialogue_number = new_middle_dialogue_number
