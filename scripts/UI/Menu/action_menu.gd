class_name ActionMenu extends Panel

signal action_button_selected(action: Action)

var _has_focus: bool = false

@onready var buttons: VBoxContainer = $Buttons

@onready var action_1: ActionButton = $Buttons/Action1
@onready var action_2: ActionButton = $Buttons/Action2
@onready var action_3: ActionButton = $Buttons/Action3
@onready var action_4: ActionButton = $Buttons/Action4

func _ready() -> void:
	
	action_1.action_button_selected.connect(Callable(self, "_on_action_selected"))
	action_2.action_button_selected.connect(Callable(self, "_on_action_selected"))
	action_3.action_button_selected.connect(Callable(self, "_on_action_selected"))
	action_4.action_button_selected.connect(Callable(self, "_on_action_selected"))


func load_actions(p_actions: Array[Action]) -> void:
	action_1.set_action(p_actions[0])
	action_2.set_action(p_actions[1])
	action_3.set_action(p_actions[2])
	action_4.set_action(p_actions[3])

func reset_actions() -> void:
	action_1.set_action(null)
	action_2.set_action(null)
	action_3.set_action(null)
	action_4.set_action(null)

func set_focus_state(p_focus_state: bool):
	_has_focus = p_focus_state
	
	if not _has_focus:
		focus_mode = Control.FOCUS_NONE
		buttons.focus_mode = Control.FOCUS_NONE
		action_1.focus_mode = Control.FOCUS_NONE
		action_2.focus_mode = Control.FOCUS_NONE
		action_3.focus_mode = Control.FOCUS_NONE
		action_4.focus_mode = Control.FOCUS_NONE
		return
	
	focus_mode = Control.FOCUS_NONE
	buttons.focus_mode = Control.FOCUS_NONE
	action_1.focus_mode = Control.FOCUS_ALL
	action_2.focus_mode = Control.FOCUS_ALL
	action_3.focus_mode = Control.FOCUS_ALL
	action_4.focus_mode = Control.FOCUS_ALL
	
	action_1.grab_focus()
		
func _on_action_selected(action_selected: Action) -> void:
	action_button_selected.emit(action_selected)
