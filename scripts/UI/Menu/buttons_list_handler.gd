class_name ButtonsListHandler

var _buttons: Array[CommandButton] = []

var _index_button_selected: int = 0

func initialize() -> void:
	_buttons.clear()


func select_next_button() -> void:
	if _index_button_selected < (_buttons.size() - 1):
		_buttons[_index_button_selected].set_is_selected(false)
		_index_button_selected += 1
		_buttons[_index_button_selected].set_is_selected(true)

func select_previous_button() -> void:
	if _index_button_selected > 0:
		_buttons[_index_button_selected].set_is_selected(false)
		_index_button_selected -= 1
		_buttons[_index_button_selected].set_is_selected(true)

func select_all() -> void:
	for button: CommandButton in _buttons:
		button.set_is_selected(true)

func select_first() -> void:
	if _buttons.size() > 0:
		_index_button_selected = 0
		_buttons[0].set_is_selected(true)

func unselect_all() -> void:
	for button: CommandButton in _buttons:
		button.set_is_selected(false)

func _is_button_selected(button: CommandButton) -> bool:
	return button.get_is_selected()

func get_buttons_selected() -> Array[CommandButton]:
	return _buttons.filter(_is_button_selected)

func remove_all_buttons() -> void:
	for button: CommandButton in _buttons:
		var parent_node = button.get_parent()
		parent_node.remove_child(button)
		button.queue_free()
	_buttons.clear()
