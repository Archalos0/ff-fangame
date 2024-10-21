class_name SpellButton extends CommandButton

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
