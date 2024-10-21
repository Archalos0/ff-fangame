class_name ActionButton extends CommandButton

signal action_button_selected(action: Action)

var action: Action


func _ready() -> void:
	initialize()
	
func set_action(new_action: Action):
	if new_action == null:
		action = null
		text = ""
	else:
		action = new_action
		text = action.action_name
	
func _on_focus_entered() -> void:
	on_focus_entered()

func _on_focus_exited() -> void:
	on_focus_exited()
	
func _on_resized() -> void:
	on_resized()

func _on_button_up() -> void:
	action_button_selected.emit(action)
