extends ColorRect

onready var back_button = $pause_options/back
onready var restart_button = $pause_options/restart_level
onready var main_menu_button = $pause_options/main_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if back_button.connect("pressed", self, "_on_back_button_pressed") != OK:
		push_error("back button connect fail")
	if restart_button.connect("pressed", self, "_on_restart_button_pressed") != OK:
		push_error("restart button connect fail")
	if main_menu_button.connect("pressed", self, "_on_main_menu_button_pressed") != OK:
		push_error("main menu button connect fail")

func _on_back_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	if get_tree().change_scene("res://src/world/board/board.tscn") != OK:
		push_error("fail to load world")


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	if get_tree().change_scene("res://src/menu/MainMenu.tscn") != OK:
		push_error("fail to load world")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = false
		visible = false
