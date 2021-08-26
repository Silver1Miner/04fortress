extends Control

var page := "0"
var text_playing = true
var dialogue = {}
onready var text := $options/textbox/text
onready var profile := $options/nametagbox/profile
onready var timer := $Timer
onready var next_button := $options/buttonbox/next
onready var skip_button := $options/buttonbox/skip
var profiles = {
	"red": preload("res://assets/profile/officer-red.png"),
	"blu": preload("res://assets/profile/officer-blu.png")
}
signal text_finished

func _ready() -> void:
	timer.wait_time = 0.05
	timer.autostart = true
	if timer.connect("timeout", self, "_on_timer_timeout") != OK:
		push_error("timer connect fail")
	if next_button.connect("pressed", self, "_on_next_pressed") != OK:
		push_error("next button connect fail")
	if skip_button.connect("pressed", self, "_on_skip_pressed") != OK:
		push_error("skip button connect fail")
	visible = false
	#initialize(test_dialogue)

var test_dialogue = {
	"0": {
		"name": "red",
		"text": "0123456789!"
	},
	"1": {
		"name": "red",
		"text": "for freedom"
	},
	"2": {
		"name": "blu",
		"text": "the quick brown fox jumps over the lazy dog"
	}
}

func initialize(scene) -> void:
	visible = true
	timer.start()
	dialogue = scene
	text_playing = true
	page = "0"
	if not page in dialogue:
		end_text()
	text.set_bbcode(dialogue[page]["text"])
	profile.texture = profiles[dialogue[page]["name"]]
	text.set_visible_characters(0)
	set_process_input(true)

func _on_next_pressed() -> void:
	if text_playing:
		if text.get_visible_characters() > text.get_total_character_count():
			if int(page) < dialogue.size() - 1:
				page = str(int(page) + 1)
				text.set_bbcode(dialogue[page]["text"])
				profile.texture = profiles[dialogue[page]["name"]]
				text.set_visible_characters(0)
			elif int(page) >= dialogue.size() - 1:
				end_text()
		else:
			text.set_visible_characters(text.get_total_character_count())

func _on_skip_pressed() -> void:
	if text_playing:
		end_text()

func _input(event) -> void:
	if text_playing:
		if event.is_action_pressed("ui_accept") or event.is_action_pressed("left_click"):
			_on_next_pressed()
		if (event.is_action_pressed("ui_cancel") or event.is_action_pressed("right_click")):
			end_text()

func end_text() -> void:
	get_tree().paused = false
	visible = false
	emit_signal("text_finished")

func _on_timer_timeout() -> void:
	text.set_visible_characters(text.get_visible_characters()+1)
