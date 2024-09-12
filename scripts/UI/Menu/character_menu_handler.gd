class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func load_characters(p_characters: Array[Character]):
	characters = p_characters
	_buttons.initialize()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Validate"):
			_send_characters()
			_reset_ui()
			return
		
		if event.is_action_pressed("Next") and not _are_all_selected:
			_buttons.select_next_button()
			return
		
		if event.is_action_pressed("Previous") and not _are_all_selected:
			_buttons.select_previous_button()
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
