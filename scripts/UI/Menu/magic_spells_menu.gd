class_name MagicSpellsMenu extends MenuHandler

signal spell_selected(spell: Spell)

@onready var level_1: HBoxContainer = $ScrollContainer/Buttons/Level1
@onready var level_2: HBoxContainer = $ScrollContainer/Buttons/Level2
@onready var level_3: HBoxContainer = $ScrollContainer/Buttons/Level3
@onready var level_4: HBoxContainer = $ScrollContainer/Buttons/Level4
@onready var level_5: HBoxContainer = $ScrollContainer/Buttons/Level5
@onready var level_6: HBoxContainer = $ScrollContainer/Buttons/Level6
@onready var level_7: HBoxContainer = $ScrollContainer/Buttons/Level7
@onready var level_8: HBoxContainer = $ScrollContainer/Buttons/Level8

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey: 
		if event.is_action_pressed("Validate"):
			_send_spell()
			_reset_ui()
			return
		if event.is_action_pressed("Next"):
			return
		if event.is_action_pressed("Previous"):
			return
		if event.is_action_pressed("HNext"):
			return
		if event.is_action_pressed("HPrevious"):
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
	level_2.get_child(2).get_child(0).set_spell(magics.level_2.slot_1)
	level_2.get_child(2).get_child(1).set_spell(magics.level_2.slot_2)
	level_2.get_child(2).get_child(2).set_spell(magics.level_2.slot_3)
	level_3.get_child(2).get_child(0).set_spell(magics.level_3.slot_1)
	level_3.get_child(2).get_child(1).set_spell(magics.level_3.slot_2)
	level_3.get_child(2).get_child(2).set_spell(magics.level_3.slot_3)
	level_4.get_child(2).get_child(0).set_spell(magics.level_4.slot_1)
	level_4.get_child(2).get_child(1).set_spell(magics.level_4.slot_2)
	level_4.get_child(2).get_child(2).set_spell(magics.level_4.slot_3)
	level_5.get_child(2).get_child(0).set_spell(magics.level_5.slot_1)
	level_5.get_child(2).get_child(1).set_spell(magics.level_5.slot_2)
	level_5.get_child(2).get_child(2).set_spell(magics.level_5.slot_3)
	level_6.get_child(2).get_child(0).set_spell(magics.level_6.slot_1)
	level_6.get_child(2).get_child(1).set_spell(magics.level_6.slot_2)
	level_6.get_child(2).get_child(2).set_spell(magics.level_6.slot_3)
	level_7.get_child(2).get_child(0).set_spell(magics.level_7.slot_1)
	level_7.get_child(2).get_child(1).set_spell(magics.level_7.slot_2)
	level_7.get_child(2).get_child(2).set_spell(magics.level_7.slot_3)
	level_8.get_child(2).get_child(0).set_spell(magics.level_8.slot_1)
	level_8.get_child(2).get_child(1).set_spell(magics.level_8.slot_2)
	level_8.get_child(2).get_child(2).set_spell(magics.level_8.slot_3)
	
	
	
	#for spells: Spells in :
		#var action_button: ActionButton = ACTION_BUTTON.instantiate()
		#action_button.set_action(action)
		#_buttons.add_child(action_button)
	#_buttons.initialize()

#func delete_actions() -> void:

func set_focus_state(p_focus_state: bool, p_authorize_multiple_selection: bool = false) -> void:
	_has_focus = p_focus_state
	
	if not _has_focus:
		_reset_ui()
		return
	
	_authorize_multiple_selection = p_authorize_multiple_selection
	_current_mode_selection = MODE_SELECTION.SINGLE
	focus_mode = Control.FOCUS_ALL
	grab_focus()
	_buttons.select_first()
