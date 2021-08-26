extends Level

var new_level_number := 2
var new_middle_dialogue_number := 2
var new_next_level_path := "res://src/world/levels/Level3.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i",
	2: "m,1,m,1,m,2,m",
	3: "m,1,m,1,m,2,m",
	4: "m,1,m,1,m,2,m",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "This is level 2."
	},
}
var new_middle_dialogue := {
	"0": {
		"name": "blu",
		"text": "Time to get serious. Send in the heavy infantry."
	}
}
var new_ending_dialogue := {
	"0": {
		"name": "blu",
		"text": "How did we lose?"
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
