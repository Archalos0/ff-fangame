class_name MessageBox extends Panel

@onready var message: Label = $Message

func _ready() -> void:
	print("fuck")

func set_message(new_message: String):
	message.text = new_message

func is_init() -> bool:
	return message != null
