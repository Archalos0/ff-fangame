class_name PlayerCharacterButton extends CommandButton

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
	character_name.text = character.character_data.character_name
	hp.text = str(character.character_data.stats.health_point) + " / " + str(character.character_data.stats.health_point)
	action_selected.text = ""

func set_is_selected(p_is_selected: bool):
	super(p_is_selected)
	if _is_selected:
		character.arrow_character_selection.visible = true
	else:
		character.arrow_character_selection.visible = false
