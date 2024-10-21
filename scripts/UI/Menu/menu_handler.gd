class_name MenuHandler extends Panel

enum MODE_SELECTION {
	SINGLE,
	MULTIPLE,
}

var _buttons_list: ButtonsListHandler = ButtonsListHandler.new()

@onready var _buttons: ButtonsHandler = $Buttons

var _has_focus: bool = false
var _authorize_multiple_selection: bool = false
var _current_mode_selection: MODE_SELECTION = MODE_SELECTION.SINGLE 

func _ready() -> void:
	focus_mode = Panel.FOCUS_NONE
	if _buttons != null : _buttons.initialize()

#func select_all():
	#if _has_focus: 
		#if _authorize_multiple_selection:
			#_current_mode_selection = MODE_SELECTION.MULTIPLE
			#_buttons.select_all()
			#grab_focus()
		#else:
			#push_error("Le menu " + name + " n'authorize pas la sélection multiple")
	#else:
		#push_error("Le menu " + name + " n'a pas le focus")

func _reset_ui() -> void:
	_buttons_list.unselect_all()
	focus_mode = Control.FOCUS_NONE
	#_buttons.focus_mode = Control.FOCUS_NONE
	_authorize_multiple_selection = false
	_current_mode_selection = MODE_SELECTION.SINGLE

func switch_selection_mode() -> void:
	if _authorize_multiple_selection == true:
		match _current_mode_selection:
			MODE_SELECTION.SINGLE:
				_current_mode_selection = MODE_SELECTION.MULTIPLE
				_buttons.unselect_all()
				_buttons.select_all()
			MODE_SELECTION.MULTIPLE:
				_current_mode_selection = MODE_SELECTION.SINGLE
				_buttons.unselect_all()
				_buttons.select_first()
	else:
		push_error("impossible de changer le mode de selection")

func set_focus_state(p_focus_state: bool, p_authorize_multiple_selection: bool = false) -> void:
	_has_focus = p_focus_state
	
	if not _has_focus:
		_reset_ui()
		return
	
	_authorize_multiple_selection = p_authorize_multiple_selection
	_current_mode_selection = MODE_SELECTION.SINGLE
	focus_mode = Control.FOCUS_NONE
	_buttons.focus_mode = Control.FOCUS_NONE
	_buttons_list.select_first()

func _load_ui():
	push_error("The method _load_ui() has not been implementing in the derived class")
	
