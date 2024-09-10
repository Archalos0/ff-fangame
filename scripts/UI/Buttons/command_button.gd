class_name CommandButton extends Button

@onready var hand_selection: Sprite2D

var _is_selected: bool = false

func _ready() -> void:
	initialize()

func initialize():
	hand_selection = get_node("HandSelection")
	if not hand_selection:
		push_error("HandSelection node is missing in the inherited scene.")
		return
	
	hand_selection.visible = false
	hand_selection.position.y = size.y / 2

func get_is_selected() -> bool:
	return _is_selected

func set_is_selected(p_is_selected: bool):
	_is_selected = p_is_selected
	if _is_selected:
		hand_selection.visible = true
	else:
		hand_selection.visible = false

func on_focus_entered():
	hand_selection.visible = true

func on_focus_exited():
	hand_selection.visible = false
