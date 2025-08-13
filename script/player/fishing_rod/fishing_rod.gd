extends Node3D

@onready var rod_tip = $RodTip
@onready var bobber = $Bobber
@onready var line_mesh = $LineMesh

func _process(delta):
	var mesh = ImmediateMesh.new()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_add_vertex(rod_tip.global_position)
	mesh.surface_add_vertex(bobber.global_position)
	mesh.surface_end()
	line_mesh.mesh = mesh
