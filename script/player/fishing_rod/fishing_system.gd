extends Node3D

@onready var button_catch : Button = $catch
var json_file : Resource
var items : Array = []

func _set_csv_path(resource: Resource):
	json_file = resource

func _load_json():
	if not json_file:
		push_error("Aucun JSON assigné !")
		return

	var file_path = json_file.resource_path
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		push_error("Impossible d'ouvrir le JSON")
		return

	var text = file.get_as_text()
	file.close()

	var result = JSON.parse_string(text)
	if result.error != OK:
		push_error("Erreur JSON : %s" % result.error_string)
		return
	
	items = result.result  # Array d'objets
	print("JSON chargé :", items)
