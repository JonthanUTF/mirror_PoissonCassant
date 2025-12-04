extends Control

@export var font: Font = null
@export var typing_speed: float = 0.03
@export var button_min_height: int = 72

@onready var texture_rect = $TextureRect
@onready var label = $MarginContainer/Label
@onready var choices_container = $HBoxContainer

signal next_line
signal choice_selected(choice_dict)

var line: String = ""
var char_index: int = 0
var time_passed: float = 0.0
var is_typing: bool = false
var is_showing_choices: bool = false

var choice_stylebox: StyleBoxTexture = null

func _ready() -> void:
	# Making children ignore mouse so the roots Control gets GUI events
	# except HBoxContainer (container with player answers)
	texture_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$MarginContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	visible = false
	clear_choices()

func set_styles(bubble_texture_path: String, npc_choice_stylebox: StyleBoxTexture) -> void:
	var bubble_texture = load(bubble_texture_path)
	if bubble_texture:
		texture_rect.texture = bubble_texture
	else:
		push_error("DialogueBubble: could not load texture: " + bubble_texture_path)
	
	label.add_theme_font_override("font", font)
	choice_stylebox = npc_choice_stylebox

func show_text(text: String) -> void:
	line = text
	char_index = 0
	label.text = ""
	is_typing = true
	visible = true

func _process(delta: float) -> void:
	if is_typing:
		time_passed += delta
		if time_passed >= typing_speed:
			time_passed = 0.0
			if char_index < line.length():
				char_index += 1
				label.text = line.substr(0, char_index)
			else:
				is_typing = false

# Detect clicks ont GUI dialogue bubble
func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		handle_click()

# Detect clicks outside of GUI dialogue bubble
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		handle_click();

func handle_click() -> void:
	if is_showing_choices:
		return
	if visible:
		if is_typing:
			label.text = line
			is_typing = false
		else:
			emit_signal("next_line")

func clear_choices() -> void:
	for child in choices_container.get_children():
		child.queue_free()
	choices_container.visible = false
	is_showing_choices = false

func show_choices(choices: Array) -> void:
	clear_choices()
	if choices.is_empty():
		return
	
	choices_container.visible = true
	is_showing_choices = true
	
	for choice in choices:
		var button: Button = Button.new()
		button.text = str(choice.get("text", "???"))
		
		button.add_theme_stylebox_override("normal", choice_stylebox)
		button.add_theme_stylebox_override("hover", choice_stylebox)
		button.add_theme_stylebox_override("pressed", choice_stylebox)
		button.add_theme_stylebox_override("focus", choice_stylebox)
		
		button.add_theme_font_override("font", font)
		button.add_theme_color_override("font_color", Color(0, 0, 0))
		button.add_theme_color_override("font_hover_color", Color(0.5, 0.5, 0.5))
		button.add_theme_color_override("font_color_pressed", Color(0, 0, 0))
		button.add_theme_font_size_override("font_size", 20)

		button.custom_minimum_size = Vector2(0, button_min_height)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.pressed.connect(Callable(self, "on_choice_pressed").bind(choice))
		choices_container.add_child(button)

func on_choice_pressed(choice: Dictionary) -> void:
	emit_signal("choice_selected", choice)
	clear_choices()
