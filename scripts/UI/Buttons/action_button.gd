class_name ActionButton extends CommandButton

@export var action_resource: ActionResource
var action: Action

func _ready() -> void:
	initialize()

func load_action_resource():
	#set_action(Action.from_action_resource(action_resource))
	pass
	
func set_action(new_action: Action):
	action = new_action
	text = action.action_name
	
func _on_focus_entered() -> void:
	on_focus_entered()

func _on_focus_exited() -> void:
	on_focus_exited()
