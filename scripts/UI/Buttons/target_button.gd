class_name TargetButton extends CommandButton

signal target_button_selected(battler: Battler)

@export var character: Battler

func _ready() -> void:
	initialize()

func set_character(new_character: Battler):
	character = new_character
	text = character.get_character_name()

func _on_focus_entered() -> void:
	on_focus_entered()
	character.arrow_character_selection.visible = true

func _on_focus_exited() -> void:
	on_focus_exited()
	character.arrow_character_selection.visible = false

func _on_button_up() -> void:
	target_button_selected.emit(character)
