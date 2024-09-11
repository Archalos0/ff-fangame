class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func load_characters(p_characters: Array[Character]):
	characters = p_characters

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_pressed("Validate"):
		_send_characters()
		_reset_ui()
		return

func _send_characters():
	var characters: Array[Character] = []

	if self is PlayerSelectionMenu:
		for character_button: PlayerCharacterButton in _buttons.get_buttons_selected():
			characters.append(character_button.character)
	elif self is TargetSelectionMenu:
		for character_button: TargetButton in _buttons.get_buttons_selected():
				characters.append(character_button.character)
	
	turn_queue.emit_signal("target_selected", characters)

func select_all_character():
	_are_all_selected = true
	_buttons.select_all()
