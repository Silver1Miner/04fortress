extends Control

signal build_mode(mode)
signal next_wave

onready var money_label = $status_bar/status/money
onready var hp_label = $status_bar/status/health
onready var to_plain_button = $terrain_bar/VBoxContainer/options/to_plain
onready var to_road_button = $terrain_bar/VBoxContainer/options/to_road
onready var to_barrier_button = $terrain_bar/VBoxContainer/options/to_barrier
onready var to_forest_button = $terrain_bar/VBoxContainer/options/to_forest
onready var build_gen_button = $tower_bar/tower_build/options/build_gen
onready var build_mg_button = $tower_bar/tower_build/options/build_mg
onready var build_vul_button = $tower_bar/tower_build/options/build_vul
onready var build_art_button = $tower_bar/tower_build/options/build_art
onready var build_rkt_button = $tower_bar/tower_build/options/build_rkt
onready var demolish_button = $tower_bar/tower_build/options/remove
onready var wave_number = $next_wave/wave_status/wave_number
onready var wave_unit_count = $next_wave/wave_status/wave_unit_count
onready var next_wave_button = $next_wave/wave_status/next_wave_button
onready var pause_menu = $pause_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if to_plain_button.connect("toggled", self, "_on_plain_toggled") != OK:
		push_error("button connect fail")
	if to_road_button.connect("toggled", self, "_on_road_toggled") != OK:
		push_error("button connect fail")
	if to_barrier_button.connect("toggled", self, "_on_barrier_toggled") != OK:
		push_error("button connect fail")
	if to_forest_button.connect("toggled", self, "_on_forest_toggled") != OK:
		push_error("button connect fail")
	if build_gen_button.connect("toggled", self, "_on_gen_toggled") != OK:
		push_error("button connect fail")
	if build_mg_button.connect("toggled", self, "_on_mg_toggled") != OK:
		push_error("button connect fail")
	if build_vul_button.connect("toggled", self, "_on_vul_toggled") != OK:
		push_error("button connect fail")
	if build_art_button.connect("toggled", self, "_on_art_toggled") != OK:
		push_error("button connect fail")
	if build_rkt_button.connect("toggled", self, "_on_rkt_toggled") != OK:
		push_error("button connect fail")
	if demolish_button.connect("toggled", self, "_on_demolish_toggled") != OK:
		push_error("demolish connect fail")
	if next_wave_button.connect("pressed", self, "_on_next_wave_button_pressed") != OK:
		push_error("next wave button connect fail")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			pause_menu.visible = false
			get_tree().paused = false
		else:
			pause_menu.visible = true
			get_tree().paused = true

func update_money(new_value) -> void:
	money_label.text = "$." + str(new_value)

func update_health(new_value) -> void:
	hp_label.text = "HP: " + str(new_value)

func update_wave_number(new_value) -> void:
	wave_number.text = "Wave " + str(new_value)

func update_wave_unit_count(new_value) -> void:
	wave_unit_count.text = "Enemies: " + str(new_value)

func untoggle_terrain() -> void:
	for button in $terrain_bar/VBoxContainer/options.get_children():
		button.pressed = false

func untoggle_towers() -> void:
	for button in $tower_bar/tower_build/options.get_children():
		button.pressed = false

func _on_plain_toggled(toggled) -> void:
	if toggled:
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()
		emit_signal("build_mode", 0)
	else:
		emit_signal("build_mode", -1)

func _on_road_toggled(toggled) -> void:
	if toggled:
		to_plain_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()
		emit_signal("build_mode", 3)
	else:
		emit_signal("build_mode", -1)

func _on_barrier_toggled(toggled) -> void:
	if toggled:
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()
		emit_signal("build_mode", 2)
	else:
		emit_signal("build_mode", -1)

func _on_forest_toggled(toggled) -> void:
	if toggled:
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		untoggle_towers()
		emit_signal("build_mode", 1)
	else:
		emit_signal("build_mode", -1)

func _on_gen_toggled(toggled) -> void:
	if toggled:
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 4)
	else:
		emit_signal("build_mode", -1)

func _on_mg_toggled(toggled) -> void:
	if toggled:
		build_gen_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 5)
	else:
		emit_signal("build_mode", -1)

func _on_vul_toggled(toggled) -> void:
	if toggled:
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 6)
	else:
		emit_signal("build_mode", -1)

func _on_art_toggled(toggled) -> void:
	if toggled:
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 7)
	else:
		emit_signal("build_mode", -1)

func _on_rkt_toggled(toggled) -> void:
	if toggled:
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 8)
	else:
		emit_signal("build_mode", -1)

func _on_demolish_toggled(toggled) -> void:
	if toggled:
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()
		emit_signal("build_mode", 9)
	else:
		emit_signal("build_mode", -1)

func _on_next_wave_button_pressed() -> void:
	emit_signal("next_wave")

func enable_next_wave_button(ready: bool) -> void:
	next_wave_button.disabled = !ready
