class_name TargetButton extends CommandButton

@export var character: Character

func _ready() -> void:
	initialize()

func set_character(new_character: Character):
	character = new_character
	text = character.character_name

	
func set_is_selected(p_is_selected: bool):
	super(p_is_selected)
	if _is_selected:
		character.arrow_character_selection.visible = true
	else:
		character.arrow_character_selection.visible = false
