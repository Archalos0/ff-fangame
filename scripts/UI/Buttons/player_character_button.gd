class_name PlayerCharacterButton extends CommandButton

signal character_selected(character: Battler)
signal change_mode_selection()

@onready var h_box_container: HBoxContainer = $HBoxContainer

@onready var character_name: Label = $HBoxContainer/CharacterName
@onready var hp: Label = $HBoxContainer/HP
@onready var action_selected: Label = $HBoxContainer/ActionSelected

@export var character: Battler

func _ready() -> void:
	initialize()
	character_name.text = "Hero"
	hp.text = "100 / 100"
	action_selected.text = ""

func set_character(new_character: Battler):
	character = new_character
	character_name.text = character.get_character_name()
	hp.text = str(character.get_current_health_points()) + " / " + str(character.get_max_health_points())
	action_selected.text = ""
	
	character.spell_is_cast.connect(Callable(self, "_on_spell_is_cast"))

func set_is_selected(p_is_selected: bool):
	super(p_is_selected)
	if _is_selected:
		character.arrow_character_selection.visible = true
	else:
		character.arrow_character_selection.visible = false

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Change_Mode_Selection"):
			change_mode_selection.emit()

func _on_focus_entered() -> void:
	set_is_selected(true)

func _on_focus_exited() -> void:
	set_is_selected(false)

func _on_button_up() -> void:
	var arr: Array[Battler] = []
	arr.append(character)
	character_selected.emit(arr)

func _on_spell_is_cast():
	action_selected.text = character.spell_cast.spell.spell_name
