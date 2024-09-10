extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	focus_mode = VBoxContainer.FOCUS_ALL
	pass # Replace with function body.

func _gui_input(event: InputEvent) -> void:
	print("coucou")
	print(event)
