class_name ActionMenu extends MenuHandler

const ACTION_BUTTON = preload("res://scenes/UI/action_button.tscn")
@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey: 
		if event.is_action_pressed("Validate"):
			_send_action()
			return
		if event.is_action_pressed("Next"):
			_buttons.select_next_button()
			return
		if event.is_action_pressed("Previous"):
			_buttons.select_previous_button()
			return
			

func _send_action():
	var buttons_selected: Array[CommandButton] = _buttons.get_buttons_selected()
	if buttons_selected.size() == 0:
		push_error("Pas d'action sélectionnée")
		return
	
	if buttons_selected.size() > 1:
		push_error("Plus d'une action sélectionnée")
		return
	
	turn_queue.emit_signal("action_selected", buttons_selected[0].action)

func load_actions(p_actions: Array[Action]):
	for action: Action in p_actions:
		var action_button: ActionButton = ACTION_BUTTON.instantiate()
		action_button.set_action(action)
		_buttons.add_child(action_button)
	_buttons.initialize()

func delete_actions():
	_buttons.remove_all_buttons()
