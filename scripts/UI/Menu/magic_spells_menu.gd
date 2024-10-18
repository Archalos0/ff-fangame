class_name MagicSpellsMenu extends MenuHandler

signal spell_selected(spell: Spell)

const SPELL_BUTTON = preload("res://scenes/UI/spell_button.tscn")

@onready var level_1: HBoxContainer = $ScrollContainer/Buttons/Level1
@onready var level_2: HBoxContainer = $ScrollContainer/Buttons/Level2
@onready var level_3: HBoxContainer = $ScrollContainer/Buttons/Level3
@onready var level_4: HBoxContainer = $ScrollContainer/Buttons/Level4
@onready var level_5: HBoxContainer = $ScrollContainer/Buttons/Level5
@onready var level_6: HBoxContainer = $ScrollContainer/Buttons/Level6
@onready var level_7: HBoxContainer = $ScrollContainer/Buttons/Level7
@onready var level_8: HBoxContainer = $ScrollContainer/Buttons/Level8

func _ready() -> void:
	_containers_list.append(level_1.get_node("HBoxContainer"))
	_containers_list.append(level_2.get_node("HBoxContainer"))
	_containers_list.append(level_3.get_node("HBoxContainer"))
	_containers_list.append(level_4.get_node("HBoxContainer"))
	_containers_list.append(level_5.get_node("HBoxContainer"))
	_containers_list.append(level_6.get_node("HBoxContainer"))
	_containers_list.append(level_7.get_node("HBoxContainer"))
	_containers_list.append(level_8.get_node("HBoxContainer"))

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
	
	for spell: Spell in magics.get_all_spells():
		var spell_button: SpellButton = SPELL_BUTTON.instantiate()
		spell_button.set_spell(spell)
		_buttons_list._buttons.append(spell_button)	
	_load_ui()
	#for spells: Spells in :
		#var action_button: ActionButton = ACTION_BUTTON.instantiate()
		#action_button.set_action(action)
		#_buttons.add_child(action_button)
	#_buttons.initialize()

#func delete_actions() -> void:

func _load_ui():
	var spell_cpt: int = 0
	
	for spell_button: CommandButton in _buttons_list._buttons:
		_containers_list[spell_cpt/3].add_child(spell_button)
		spell_cpt += 1

func delete_spells():
	_buttons_list.remove_all_buttons()

func set_focus_state(p_focus_state: bool, p_authorize_multiple_selection: bool = false) -> void:
	_has_focus = p_focus_state
	
	if not _has_focus:
		_reset_ui()
		return
	
	_authorize_multiple_selection = p_authorize_multiple_selection
	_current_mode_selection = MODE_SELECTION.SINGLE
	focus_mode = Control.FOCUS_ALL
	grab_focus()
	_buttons_list.select_first()
