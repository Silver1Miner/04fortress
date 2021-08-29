extends AudioStreamPlayer

var tt_intro = preload("res://assets/music/Terra-Tactics-Intro.ogg")
var tt_loop = preload("res://assets/music/Terra-Tactics-Loop.ogg")
var atheme = preload("res://assets/music/Approaching.ogg")

var current_track := 0
var tracks := {
	0: preload("res://assets/music/Terra-Tactics-Loop.ogg"),
	1: preload("res://assets/music/Approaching.ogg")
}

func _ready() -> void:
	pass # Replace with function body.

func play_track(number) -> void:
	if number != current_track:
		current_track = number
		stream = tracks[current_track]
		play(0)

func play_a() -> void:
	stream = atheme
	play(0)

func play_tt() -> void:
	stream = tt_loop
	play(0)
