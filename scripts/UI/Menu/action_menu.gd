class_name ActionMenu extends MenuHandler

signal ability_selected(spell: Spell)
signal open_menu(menu_id: String)

const ACTION_BUTTON = preload("res://scenes/UI/action_button.tscn")

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey: 
		if event.is_action_pressed("Validate"):
			_send_action()
			_reset_ui()
			return
		if event.is_action_pressed("Next"):
			_buttons.select_next_button()
			return
		if event.is_action_pressed("Previous"):
			_buttons.select_previous_button()
			return

func _send_action() -> void:
	var buttons_selected: Array[CommandButton] = _buttons.get_buttons_selected()
	if buttons_selected.size() == 0:
		push_error("Pas d'action sélectionnée")
		return
	
	if buttons_selected.size() > 1:
		push_error("Plus d'une action sélectionnée")
		return
	
	if buttons_selected[0].action is Action.OpenMenuAction:
		open_menu.emit(buttons_selected[0].action.menu_id)
	else:
		ability_selected.emit(buttons_selected[0].action.spell)

func load_actions(p_actions: Array[Action]) -> void:
	for action: Action in p_actions:
		var action_button: ActionButton = ACTION_BUTTON.instantiate()
		action_button.set_action(action)
		_buttons.add_child(action_button)
	_buttons.initialize()

func delete_actions() -> void:
	_buttons.remove_all_buttons()
