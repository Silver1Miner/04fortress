extends Level

var new_level_number := 4
var new_middle_dialogue_number := 2
var new_next_level_path := "res://src/menu/MainMenu.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i,1,i,4,i,1,i,1,i,1,i,3,i,1,i,1,i",
	2: "s,1,i,1,i,3,m,1,s,1,i,2,i,1,s,1,s,1,i,2,m,1,i,1,i",
	3: "m,1,m,1,m,2,i,1,a,1,a,2,i,1,i,1,m,1,i,2,i,1,i,1,i",
	4: "s,1,s,1,s,2,s,1,s,1,s,2,m,1,m,1,m,1,s,2,s,1,m,1,m,3,i,1,i,2,s,1,s,1,s",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Well, this should be the last invasion for now."
	},
	"1": {
		"name": "red",
		"text": "For this final mission, command is authorizing us to use Rocket Towers."
	},
	"2": {
		"name": "red",
		"text": "These things really pack a punch, but like with artillery cannons, we have to worry about travel time."
	},
	"3": {
		"name": "red",
		"text": "Anyways, the enemy will probably be throwing everything they have at us. Let's go!"
	},
}
var new_middle_dialogue := {
	"0": {
		"name": "blu",
		"text": "Even this sector is fortified? No matter."
	},
	"1": {
		"name": "blu",
		"text": "We'll rush them with scout cars, and follow with everything we've got."
	},
	"2": {
		"name": "blu",
		"text": "Overwhelm them with mountains of troops!"
	},
}
var new_ending_dialogue := {
	"0": {
		"name": "red",
		"text": "We did it!"
	},
	"1": {
		"name": "red",
		"text": "Great job, commander! We've repulsed the invasion."
	},
	"2": {
		"name": "red",
		"text": "Command is very impressed. I'm sure they'll trust you with something big in your next assignment."
	},
	"3": {
		"name": "red",
		"text": "I'm a bit sorry to see you go though... It was a pleasure working with you."
	},
	"4": {
		"name": "red",
		"text": "Maybe we'll be assigned to work together again in the future. I sure hope so..."
	},
	"5": {
		"name": "red",
		"text": "Goodbye, commander. Best of luck in your future endeavors!"
	},
	"6": {
		"name": "blu",
		"text": "Hmm... I see... They posted a combat engineer and a tactical advisor to oversee the defenses."
	},
	"7": {
		"name": "blu",
		"text": "This intel may prove useful in the future..."
	},
	"8": {
		"name": "blu",
		"text": "Until then..."
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
