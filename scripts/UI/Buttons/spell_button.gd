class_name SpellButton extends CommandButton

signal spell_selected(spell: Spell)
signal cancel_action()

var spell: Spell

func _ready() -> void:
	initialize()
	
func set_spell(new_spell: Spell):
	spell = new_spell
	
	if spell == null:
		return
		
	text = spell.spell_name
	
func _on_focus_entered() -> void:
	on_focus_entered()

func _on_focus_exited() -> void:
	on_focus_exited()

func _on_resized() -> void:
	on_resized()

func _on_button_up() -> void:
	spell_selected.emit(spell)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Cancel"):
			cancel_action.emit()
