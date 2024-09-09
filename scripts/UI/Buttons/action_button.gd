class_name ActionButton extends CommandButton

@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

@export var action_ressource: ActionResource
var action: Action

func _ready() -> void:
	initialize()

func load_action_ressource():
	set_action(Action.from_action_resource(action_ressource))

func set_action(new_action: Action):
	action = new_action
	text = action.action_name

func _on_button_up() -> void:
	turn_queue.action_selected.emit(action)
	
func _on_focus_entered() -> void:
	on_focus_entered()

func _on_focus_exited() -> void:
	on_focus_exited()
