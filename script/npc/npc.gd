extends Node3D

@export var npc_name: String = "NPC"
@export var player_reputation: int = 0
@export var dialogue_file: String = ""
@export var bubble_texture: String = ""
@export var choice_stylebox: StyleBoxTexture = null

var bubble: Control = null
var dialogues: Array = []
var dialogue_index_by_id: Dictionary = {}
var current_dialogue_index: int = 0
var current_line_index: int = 0

func _ready() -> void:
	bubble = get_tree().root.get_node("main/UI/DialogueBubble")
	if !bubble:
		push_error("DialogueBubble not found in UI layer")
		return
	
	bubble.visible = false
	if bubble.has_signal("next_line"):
		bubble.next_line.connect(show_next_line)
	if bubble.has_signal("choice_selected"):
		bubble.choice_selected.connect(on_choice_selected)
	load_dialogue_file()

func load_dialogue_file() -> void:
	dialogues.clear()
	dialogue_index_by_id.clear()
	if dialogue_file == "":
		return
	
	var file = FileAccess.open(dialogue_file, FileAccess.READ)
	if not file:
		push_error("Could not open dialogue file: " + dialogue_file)
		return
	var data = JSON.parse_string(file.get_as_text())
	if typeof(data) != TYPE_DICTIONARY:
		push_error("JSON dialogue file not valid for " + npc_name)
		return
	dialogues = data.get("dialogues", [])
	
	for i in dialogues.size():
		var d = dialogues[i]
		var id = d.get("id", "")
		if id != "":
			dialogue_index_by_id[id] = i

func talk() -> void:
	if not bubble or dialogues.is_empty():
		return
	
	current_dialogue_index = 0
	current_line_index = 0
	show_next_line()

func show_next_line() -> void:
	if dialogues.is_empty():
		return
	
	var dialogue = dialogues[current_dialogue_index]
	var lines = dialogue.get("text", [])
	
	if current_line_index < lines.size():
		bubble.set_styles(bubble_texture, choice_stylebox)
		bubble.show_text(lines[current_line_index])
		current_line_index += 1
		return
	
	var choices: Array = dialogue.get("choices", [])
	if choices and choices.size() > 0:
		bubble.show_choices(choices)
		return
	
	bubble.visible = false

func on_choice_selected(choice: Dictionary) -> void:
	player_reputation += int(choice.get("reputation_change", 0))
	
	var next_id = str(choice.get("next", ""))
	if next_id != "" and dialogue_index_by_id.has(next_id):
		current_dialogue_index = int(dialogue_index_by_id[next_id])
		current_line_index = 0
		show_next_line()
	else:
		bubble.visible = false
