extends Node3D

@onready var area = $Area3D

func _ready():
	area.body_entered.connect(on_body_entered)
	area.body_exited.connect(on_body_exited)

func on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		var player = body.get_parent()
		var npc = get_parent()
		player.enter_npc_area(npc)

func on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		var player = body.get_parent()
		player.exit_npc_area()
