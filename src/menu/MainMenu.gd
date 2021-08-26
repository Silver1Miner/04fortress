extends Control

onready var campaign_button = $options/campaign
onready var sandbox_button = $options/sandbox
onready var settings_button = $options/settings
onready var quit_button = $options/quit
onready var campaign_menu = $campaign_menu
onready var settings_menu = $settings_menu
onready var campaign_menu_close = $campaign_menu/close
onready var settings_menu_close = $settings_menu/close
onready var level1 = $campaign_menu/levels/level1
onready var level2 = $campaign_menu/levels/level2
onready var level3 = $campaign_menu/levels/level3
onready var level4 = $campaign_menu/levels/level4

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
	if campaign_menu_close.connect("pressed", self, "_on_close_button_pressed") != OK:
		push_error("menu close connect fail")
	if settings_menu_close.connect("pressed", self, "_on_close_button_pressed") != OK:
		push_error("menu close connect fail")
	if level1.connect("pressed", self, "_on_level1_pressed") != OK:
		push_error("level connect fail")
	if level2.connect("pressed", self, "_on_level2_pressed") != OK:
		push_error("level connect fail")
	if level3.connect("pressed", self, "_on_level3_pressed") != OK:
		push_error("level connect fail")
	if level4.connect("pressed", self, "_on_level4_pressed") != OK:
		push_error("level connect fail")

func _on_campaign_button_pressed() -> void:
	PlayerData.sandbox = false
	PlayerData.game_over = false
	campaign_menu.visible = true
	settings_menu.visible = false
	check_levels()

func check_levels() -> void:
	level2.disabled = (PlayerData.completed_levels[1] == 0)
	level3.disabled = (PlayerData.completed_levels[2] == 0)
	level4.disabled = (PlayerData.completed_levels[3] == 0)

func _on_sandbox_button_pressed() -> void:
	PlayerData.sandbox = true
	PlayerData.game_over = false
	if get_tree().change_scene("res://src/world/levels/Level.tscn") != OK:
		push_error("fail to load world")

func _on_settings_button_pressed() -> void:
	campaign_menu.visible = false
	settings_menu.visible = true

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_close_button_pressed() -> void:
	campaign_menu.visible = false
	settings_menu.visible = false

func _on_level1_pressed() -> void:
	if get_tree().change_scene("res://src/world/levels/Level1.tscn") != OK:
		push_error("fail to load world")

func _on_level2_pressed() -> void:
	if get_tree().change_scene("res://src/world/levels/Level2.tscn") != OK:
		push_error("fail to load world")

func _on_level3_pressed() -> void:
	if get_tree().change_scene("res://src/world/levels/Level3.tscn") != OK:
		push_error("fail to load world")

func _on_level4_pressed() -> void:
	if get_tree().change_scene("res://src/world/levels/Level4.tscn") != OK:
		push_error("fail to load world")
