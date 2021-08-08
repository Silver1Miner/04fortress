extends Control

signal build_mode(mode)

onready var money_label = $status_bar/status/money
onready var wave_label = $status_bar/status/wave
onready var to_plain_button = $terrain_bar/VBoxContainer/options/to_plain
onready var to_road_button = $terrain_bar/VBoxContainer/options/to_road
onready var to_barrier_button = $terrain_bar/VBoxContainer/options/to_barrier
onready var to_forest_button = $terrain_bar/VBoxContainer/options/to_forest
onready var build_gen_button = $tower_bar/tower_build/options/build_gen
onready var build_mg_button = $tower_bar/tower_build/options/build_mg
onready var build_vul_button = $tower_bar/tower_build/options/build_vul
onready var build_art_button = $tower_bar/tower_build/options/build_art
onready var build_rkt_button = $tower_bar/tower_build/options/build_rkt

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
	if connect("build_mode", self, "_on_build_mode_change") != OK:
		push_error("button connect fail")

func untoggle_terrain() -> void:
	for button in $terrain_bar/VBoxContainer/options.get_children():
		button.pressed = false

func untoggle_towers() -> void:
	for button in $tower_bar/tower_build/options.get_children():
		button.pressed = false

func _on_build_mode_change(mode) -> void:
	print("build mode changed to ", mode) 

func _on_plain_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "plain")
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_road_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "road")
		to_plain_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_barrier_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "barrier")
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_forest_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "forest")
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		untoggle_towers()

func _on_gen_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "gen")
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()

func _on_mg_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "mg")
		build_gen_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()

func _on_vul_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "vul")
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()

func _on_art_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "art")
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()

func _on_rkt_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", "rkt")
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		untoggle_terrain()
