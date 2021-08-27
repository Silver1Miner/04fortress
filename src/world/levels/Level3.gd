extends Level

var new_level_number := 3
var new_middle_dialogue_number := 2
var new_next_level_path := "res://src/world/levels/Level4.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i,1,i,4,i,1,i,1,i,1,i,3,i,1,i,1,i",
	2: "i,1,i,1,i,3,m,1,m,1,i,2,i,1,m,1,m,1,i,2,m,1,i,1,i",
	3: "m,1,m,1,m,2,i,1,a,1,a,2,i,1,i,1,m,1,i,2,i,1,i,1,i",
	4: "m,1,a,1,m,2,i,1,i,1,i,2,a,1,a,1,m,1,i,2,m,1,m,1,m",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Great news, we just got authorization to deploy artillery cannon towers!"
	},
	"1": {
		"name": "red",
		"text": "These guys pack quite a punch, but their shells have travel time."
	},
	"2": {
		"name": "red",
		"text": "The automated towers don't have enough processing power to try to lead shots, especially when enemy direction can be hard to predict."
	},
	"3": {
		"name": "red",
		"text": "We best make sure they're not too far from the action then, or else the enemy will dodge the shells easily."
	},
}
var new_middle_dialogue := {
	"0": {
		"name": "blu",
		"text": "Time to send out the mechanized infantry."
	},
	"1": {
		"name": "blu",
		"text": "There's no way they'll be able to hold them back."
	},
}
var new_ending_dialogue := {
	"0": {
		"name": "blu",
		"text": "Another defeat? Unacceptable."
	},
	"1": {
		"name": "blu",
		"text": "Gather everything we have our disposal. We'll gamble everything on one final assault."
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
