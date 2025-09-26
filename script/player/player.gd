extends Node3D

#fishing var:
@export var can_fished: bool = false
@export var fishing: bool = false
var fish_json : Resource
@onready var fishing_button = $fishing_button
@onready var anim_player: AnimationPlayer = $cornichon/AnimationPlayer
@onready var fishing_rod = $cornichon/'fishing rod'

#fishing function:
func _exit_fishing_area() -> void:
	can_fished = false
	fishing = false
	fish_json = null

func _enter_fishing_area(resource : Resource) -> void:
	can_fished = true
	fish_json = resource

func _show_button_fishing() -> void:
	if can_fished && !fishing:
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


func _process(delta) -> void:
	_show_button_fishing()
	_animation_player()
	_show_fishing_rod()
