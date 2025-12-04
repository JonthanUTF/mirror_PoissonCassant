extends Node3D

# Fishing related variables

@export var can_fish: bool = false
@export var fishing: bool = false

@onready var fish_path : String = ""
@onready var fishing_button = $fishing_button
@onready var anim_player: AnimationPlayer = $cornichon/AnimationPlayer
@onready var fishing_rod = $cornichon/'fishing rod'

# Npc related variables

@export var can_talk: bool = false
@export var talking: bool = false

@onready var npc_button = $npc_button

var target_npc: Node = null

# Fishing related functions

func _exit_fishing_area() -> void:
	can_fish = false
	fishing = false
	fish_path = ""

func _enter_fishing_area(path : String) -> void:
	can_fish = true
	fish_path = path

func _show_button_fishing() -> void:
	if can_fish:
		if !fishing:
			fishing_button.visible = true
	else:
		fishing_button.visible = false

func _show_fishing_rod() -> void:
	if (fishing):
		fishing_rod.visible = true
	else:
		fishing_rod.visible = false

func _on_fishing_button_pressed():
	fishing = true

func _animation_player():
	if (fishing):
		anim_player.play("fishing")
	else:
		anim_player.play("idle")

# NPC related functions

func enter_npc_area(npc) -> void:
	target_npc = npc
	can_talk = true

func exit_npc_area() ->void:
	target_npc = null
	can_talk = false
	talking = false

func show_button_talking() -> void:
	if can_talk and !talking and target_npc:
			npc_button.visible = true
	else:
		npc_button.visible = false

func on_npc_button_pressed():
	if target_npc:
		target_npc.talk()
		talking = true

func _process(delta) -> void:
	# Fishing
	_show_button_fishing()
	_animation_player()
	_show_fishing_rod()
	
	# Npc
	show_button_talking()
