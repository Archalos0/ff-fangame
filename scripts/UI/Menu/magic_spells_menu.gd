class_name MagicSpellsMenu extends Panel

signal spell_selected(spell: Spell)

@onready var level_1: HBoxContainer = $ScrollContainer/Buttons/Level1

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey: 
		if event.is_action_pressed("Validate"):
			_send_spell()
			#_reset_ui()
			return
		if event.is_action_pressed("Next"):
			#_buttons.select_next_button()
			return
		if event.is_action_pressed("Previous"):
			#_buttons.select_previous_button()
			return

func _send_spell() -> void:
	#var buttons_selected: Array[CommandButton] = _buttons.get_buttons_selected()
	#if buttons_selected.size() == 0:
		#push_error("Pas de spell sélectionné")
		#return
	#
	#if buttons_selected.size() > 1:
		#push_error("Plus d'un spell sélectionné")
		#return
	#
	#spell_selected.emit(buttons_selected[0].spell)
	pass
	
func load_spells(magics: Magics) -> void:
	
	level_1.get_child(2).get_child(0).set_spell(magics.level_1.slot_1)
	level_1.get_child(2).get_child(1).set_spell(magics.level_1.slot_2)
	level_1.get_child(2).get_child(2).set_spell(magics.level_1.slot_3)
	
	
	#for spells: Spells in :
		#var action_button: ActionButton = ACTION_BUTTON.instantiate()
		#action_button.set_action(action)
		#_buttons.add_child(action_button)
	#_buttons.initialize()

#func delete_actions() -> void:
