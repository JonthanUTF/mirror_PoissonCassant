extends Node3D

@export var csv_path: String

@onready var area = $Area3D

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("Joueur entré dans la zone")
		var player = body.get_parent()
		player._enter_fishing_area(csv_path)

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("Joueur sorti de la zone")
		var player = body.get_parent()
		player._exit_fishing_area()
