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
onready var demolish_button = $tower_bar/tower_build/options/remove

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

func untoggle_terrain() -> void:
	for button in $terrain_bar/VBoxContainer/options.get_children():
		button.pressed = false

func untoggle_towers() -> void:
	for button in $tower_bar/tower_build/options.get_children():
		button.pressed = false

func _on_plain_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 0)
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_road_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 3)
		to_plain_button.pressed = false
		to_barrier_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_barrier_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 2)
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_forest_button.pressed = false
		untoggle_towers()

func _on_forest_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 1)
		to_plain_button.pressed = false
		to_road_button.pressed = false
		to_barrier_button.pressed = false
		untoggle_towers()

func _on_gen_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 4)
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()

func _on_mg_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 5)
		build_gen_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()

func _on_vul_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 6)
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()

func _on_art_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 7)
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_rkt_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()

func _on_rkt_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 8)
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		demolish_button.pressed = false
		untoggle_terrain()

func _on_demolish_toggled(toggled) -> void:
	if toggled:
		emit_signal("build_mode", 9)
		build_gen_button.pressed = false
		build_mg_button.pressed = false
		build_vul_button.pressed = false
		build_art_button.pressed = false
		build_rkt_button.pressed = false
		untoggle_terrain()
