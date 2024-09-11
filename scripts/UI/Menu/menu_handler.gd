class_name MenuHandler extends Panel

@onready var _buttons: ButtonsHandler = $Buttons

var _has_focus: bool = false
var _are_all_selected: bool = false

func select_all():
	if _has_focus:
		set_are_all_selected(true)
		_buttons.select_all()
		grab_focus()
	else:
		push_error("Le menu " + name + " n'a pas le focus")

func _reset_ui():
	_buttons.unselect_all()
	focus_mode = Control.FOCUS_NONE
	_buttons.focus_mode = Control.FOCUS_NONE
	_are_all_selected = false

func get_are_all_selected():
	return _are_all_selected

func set_are_all_selected(p_are_all_selected: bool):
	_are_all_selected = p_are_all_selected

func set_focus_state(p_focus_state):
	_has_focus = p_focus_state
	
	if _has_focus == true:
		focus_mode = Control.FOCUS_ALL
		grab_focus()
		if not _are_all_selected:
			_buttons.select_first()
		else:
			_buttons.select_all()
	else:
		focus_mode = Control.FOCUS_NONE
		_buttons.unselect_all()


func get_focus_state():
	return _has_focus
