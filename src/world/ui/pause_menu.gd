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
	visible = false

func _on_back_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	PlayerData.game_over = false
	if get_tree().reload_current_scene() != OK:
		push_error("fail to reload world")

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	if get_tree().change_scene("res://src/menu/MainMenu.tscn") != OK:
		push_error("fail to load world")

func _pause_on(is_game_over: bool) -> void:
	if is_game_over:
		$pause_options/Label.text = "GAME OVER"
		back_button.visible = false
	else:
		$pause_options/Label.text = "PAUSED"
		back_button.visible = true
	visible = true
	get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if PlayerData.game_over:
			return
		if get_tree().paused:
			print("unpause pressed")
			visible = false
			get_tree().paused = false
			get_tree().set_input_as_handled()
		else:
			print("pause pressed")
			_pause_on(false)
			get_tree().set_input_as_handled()
