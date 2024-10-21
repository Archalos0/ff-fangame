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

@onready var scroll_container: ScrollContainer = $ScrollContainer

func _ready() -> void:
	_buttons_list._containers.append(level_1.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_2.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_3.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_4.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_5.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_6.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_7.get_node("HBoxContainer"))
	_buttons_list._containers.append(level_8.get_node("HBoxContainer"))
	
	_buttons_list._buttons.append(_buttons_list._containers[0].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[0].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[0].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[1].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[1].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[1].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[2].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[2].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[2].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[3].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[3].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[3].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[4].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[4].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[4].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[5].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[5].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[5].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[6].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[6].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[6].get_child(2))
	
	_buttons_list._buttons.append(_buttons_list._containers[7].get_child(0))
	_buttons_list._buttons.append(_buttons_list._containers[7].get_child(1))
	_buttons_list._buttons.append(_buttons_list._containers[7].get_child(2))
	
	scroll_container.focus_mode = Control.FOCUS_NONE
	
	set_focus_state(true)
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey: 
		if event.is_action_pressed("Validate"):
			_send_spell()
			_reset_ui()
			return
		if event.is_action_pressed("Next"):
			_buttons_list.select_bottom_button()
			return
		if event.is_action_pressed("Previous"):
			_buttons_list.select_top_button()
			return
		if event.is_action_pressed("HNext"):
			_buttons_list.select_next_button()
			return
		if event.is_action_pressed("HPrevious"):
			_buttons_list.select_previous_button()
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
	
	var cpt := 0
	for spell: Spell in magics.get_all_spells():
		#var spell_button: SpellButton = SPELL_BUTTON.instantiate()
		#spell_button.set_spell(spell)
		_buttons_list._buttons[cpt].set_spell(spell)	
		cpt += 1
	#_load_ui()
	#for spells: Spells in :
		#var action_button: ActionButton = ACTION_BUTTON.instantiate()
		#action_button.set_action(action)
		#_buttons.add_child(action_button)
	#_buttons.initialize()

#func delete_actions() -> void:

#func _load_ui():
	#var spell_cpt: int = 0
	#
	#for spell_button: CommandButton in _buttons_list._buttons:
		#_buttons_list._containers[spell_cpt/3].add_child(spell_button)
		#spell_cpt += 1

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


func _on_mouse_entered() -> void:
	print(get_viewport().gui_get_focus_owner())


func _on_scroll_container_scroll_started() -> void:
	print("scroll started")


func _on_scroll_container_scroll_ended() -> void:
	print("scroll ended")
