class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

func _ready() -> void:
	pass

func load_characters(p_characters: Array[Character]):
	characters = p_characters
