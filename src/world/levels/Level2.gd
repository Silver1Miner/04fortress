extends Level

var new_level_number := 2
var new_middle_dialogue_number := 2
var new_next_level_path := "res://src/world/levels/Level3.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i,1,i",
	2: "a,1,a,1,a,3,a,1,a,1,a,2,a,1,a,1,a",
	3: "i,1,i,1,i,3,i,1,i,1,i,2,a,1,a,1,a,2,a,1,i,1,i,1,a,3,i,1,a,1,a",
	4: "a,1,a,1,a,3,i,1,i,1,i,3,a,1,a,1,a,2,a,1,i,1,i,1,a,3,i,1,a,1,a",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Good job on clearing those first waves! It looks like the higher ups are pleased with your progress."
	},
	"1": {
		"name": "red",
		"text": "They've now authorized us to build rapid-fire gun towers here."
	},
	"2": {
		"name": "red",
		"text": "And just in time, the invaders are moving into this sector with a much stronger force than before."
	}
}
var new_middle_dialogue := {
	"0": {
		"name": "blu",
		"text": "Looks like they've boosted their defenses in this region as well."
	},
	"1": {
		"name": "blu",
		"text": "Good thing I came prepared. Time to send in the heavy infantry."
	}
}
var new_ending_dialogue := {
	"0": {
		"name": "blu",
		"text": "How did we lose?"
	},
	"1": {
		"name": "blu",
		"text": "Looks like I'll need to request even stronger troops."
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
