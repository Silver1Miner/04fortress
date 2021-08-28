extends Level

var new_level_number := 1
var new_middle_dialogue_number := 2
var new_next_level_path := "res://src/world/levels/Level2.tscn"

var new_wave_schedule := {
	1: "i,1,i,2,i,3,i,1,i",
	2: "i,1,i,2,i,3,i,1,i,1,i,2,i,3,i",
	3: "i,1,i,2,i,3,i,1,i,1,i,3,i,1,i,1,i,1,i,3,i,1,i",
	4: "i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,2,i,1,i,1,i,1,i,1,i",
}
var new_opening_dialogue := {
	"0": {
		"name": "red",
		"text": "Hi, you must be the new Tactical Officer that command sent to oversee the defenses."
	},
	"1": {
		"name": "red",
		"text": "I'm the local combat engineer. I'll be building the tower sentries and terrain modifications at your direction."
	},
	"2": {
		"name": "red",
		"text": "Tower building is straightforward. Each tower has an automated sentry that will attack any enemy in its range."
	},
	"3": {
		"name": "red",
		"text": "However, towers need flat plains to lay the foundations. That's where I come in! I can clear forests, barricades, and roads to open space for more towers."
	},
	"4": {
		"name": "red",
		"text": "Our building ability is limited by our budget. Command pays a bounty for each invader we take out."
	},
	"5": {
		"name": "red",
		"text": "But if we're really short on cash, we can make some by harvesting woods, barricades, or roads for the resources too!"
	},
	"6": {
		"name": "red",
		"text": "Anyways, how you want to handle the invaders is all up to you commander! Let's work well together!"
	},
}
var new_middle_dialogue := {
	"0": {
		"name": "red",
		"text": "You may have noticed that we only have one tower type available at the moment."
	},
	"1": {
		"name": "red",
		"text": "Command is a bit stingy about authorizing use of more advanced towers, but if we do well, I'm sure they'll authorize some more types for us!"
	},
	"2": {
		"name": "red",
		"text": "In the meantime, we can amuse ourselves by modifying the terrain in clever ways."
	},
	"3": {
		"name": "red",
		"text": "If we modify terrain while the enemy waves are coming, we can slow their advance!"
	},
	"4": {
		"name": "red",
		"text": "After all, traveling through woods or over barricades takes longer than going over a plain, and especially over a road."
	},
	"5": {
		"name": "red",
		"text": "But we should be careful too. The enemy can adjust their attack route in between their waves. They're always looking for the path of least resistance."
	},
}
var new_ending_dialogue := {
	"0": {
		"name": "blu",
		"text": "Hmm, what's this? The invasion force was defeated by sentry defenses?"
	},
	"1": {
		"name": "blu",
		"text": "I wasn't expecting there to be resistance in this area. Perhaps I will have to try a different sector."
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
