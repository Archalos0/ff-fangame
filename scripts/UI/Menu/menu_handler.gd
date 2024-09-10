class_name MenuHandler extends Panel

@onready var buttons: VBoxContainer = $Buttons

var _has_focus: bool = false
var _are_all_selected: bool = false

func _ready() -> void:
	buttons = get_node("Buttons")

func select_all():
	if _has_focus:
		set_are_all_selected(true) 
		for button: CommandButton in buttons.get_children():
			button.set_is_selected(true)
		grab_focus()
	else:
		push_error("Le menu " + name + " n'a pas le focus")

func get_are_all_selected():
	return _are_all_selected

func set_are_all_selected(p_are_all_selected: bool):
	_are_all_selected = p_are_all_selected

func set_focus_state(p_focus_state):
	_has_focus = p_focus_state
	if _has_focus == true:
		if not _are_all_selected:
			for button: CommandButton in buttons.get_children():
				button.focus_mode = Control.FOCUS_ALL
			buttons.get_child(0).grab_focus()
		else:
			if buttons.get_child_count() > 0:
				for button: CommandButton in buttons.get_children():
					button.focus_mode = Control.FOCUS_NONE
				var button: CommandButton = buttons.get_child(0)
				button.set_is_selected(true)
			focus_mode = Control.FOCUS_ALL
			grab_focus()
	else:
		if buttons.get_child_count() > 0:
			for button: CommandButton in buttons.get_children():
					button.focus_mode = Control.FOCUS_NONE

func get_focus_state():
	return _has_focus
