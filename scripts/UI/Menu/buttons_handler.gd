class_name ButtonsHandler extends VBoxContainer

var _buttons: Array[CommandButton] = []

var _index_button_selected: int = 0

func initialize():
	_buttons.clear()
	for command_button: CommandButton in get_children():
		_buttons.append(command_button)

func select_next_button():
	if _index_button_selected < (_buttons.size() - 1):
		_buttons[_index_button_selected].set_is_selected(false)
		_index_button_selected += 1
		_buttons[_index_button_selected].set_is_selected(true)

func select_previous_button():
	if _index_button_selected > 0:
		_buttons[_index_button_selected].set_is_selected(false)
		_index_button_selected -= 1
		_buttons[_index_button_selected].set_is_selected(true)

func select_all():
	for button: CommandButton in _buttons:
		button.set_is_selected(true)

func select_first():
	if _buttons.size() > 0:
		_buttons[0].set_is_selected(true)
		
func unselect_all():
	for button: CommandButton in _buttons:
		button.set_is_selected(false)

func _is_button_selected(button: CommandButton) -> bool:
	return button.get_is_selected()

func get_buttons_selected() -> Array[CommandButton]:
	return _buttons.filter(_is_button_selected)

func remove_all_buttons():
	for button: CommandButton in _buttons:
		remove_child(button)
		button.queue_free()
	_buttons.clear()

func get_buttons():
	return _buttons
