extends Node3D

@export var template_json: Resource
const SAVE_DIR := "res://save/fishing_area"

@onready var area = $Area3D

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	get_or_create_json_copy(template_json)

# Fonction principale
func get_or_create_json_copy(original: Resource) -> Resource:
	if not original:
		push_error("Missing fishing resources")
		return null

	# Nom du fichier de sauvegarde
	var filename = original.resource_name + ".json"
	var save_path = SAVE_DIR + filename

	# Si le fichier existe déjà, retourne la Resource existante
	if FileAccess.file_exists(save_path):
		return load(save_path)

	# Sinon, copie le fichier original vers save/
	var original_path = original.resource_path
	var original_file = FileAccess.open(original_path, FileAccess.READ)
	if not original_file:
		return null
	var text = original_file.get_as_text()
	original_file.close()

	# Écriture du fichier dans le dossier save
	var out_file = FileAccess.open(save_path, FileAccess.WRITE)
	if not out_file:
		push_error("Can't make a copy : %s" % save_path)
		return null
	out_file.store_string(text)
	out_file.close()

	# Retourne la Resource copiée
	return load(save_path)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("Joueur entré dans la zone")
		var player = body.get_parent()
		player._enter_fishing_area(get_or_create_json_copy(template_json))

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print("Joueur sorti de la zone")
		var player = body.get_parent()
		player._exit_fishing_area()
