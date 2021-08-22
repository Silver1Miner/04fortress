extends Control

onready var campaign_button = $options/campaign
onready var sandbox_button = $options/sandbox
onready var settings_button = $options/settings
onready var quit_button = $options/quit

func _ready() -> void:
	if OS.get_name() == "HTML5":
		quit_button.visible = false
	if campaign_button.connect("pressed", self, "_on_campaign_button_pressed") != OK:
		push_error("campaign button connect fail")
	if sandbox_button.connect("pressed", self, "_on_sandbox_button_pressed") != OK:
		push_error("sandbox button connect fail")
	if settings_button.connect("pressed", self, "_on_settings_button_pressed") != OK:
		push_error("sandbox button connect fail")
	if quit_button.connect("pressed", self, "_on_quit_button_pressed") != OK:
		push_error("sandbox button connect fail")

func _on_campaign_button_pressed() -> void:
	PlayerData.sandbox = false
	if get_tree().change_scene("res://src/world/board/board.tscn") != OK:
		push_error("fail to load world")

func _on_sandbox_button_pressed() -> void:
	PlayerData.sandbox = true
	if get_tree().change_scene("res://src/world/board/board.tscn") != OK:
		push_error("fail to load world")

func _on_settings_button_pressed() -> void:
	print("settings button pressed")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
