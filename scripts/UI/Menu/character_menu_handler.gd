class_name CharacterMenuHandler extends MenuHandler

var characters: Array[Character] = []

@onready var turn_queue: TurnQueue = $"/root/BattleScene/TurnQueue"

func load_characters(p_characters: Array[Character]):
	characters = p_characters

func _gui_input(event: InputEvent) -> void:
	if _are_all_selected:
		if event is InputEventKey and event.is_action_pressed("Validate"):
			_send_characters()
			_reset_ui()
		return

func _send_characters():
	var characters: Array[Character] = []
	if self is PlayerSelectionMenu:
		for character_button: PlayerCharacterButton in buttons.get_children():
			characters.append(character_button.character)
	elif self is TargetSelectionMenu:
		for character_button: TargetButton in buttons.get_children():
				characters.append(character_button.character)
	#match name:
		#"PlayerCharacterInformations":
			#for character_button: PlayerCharacterButton in buttons.get_children():
			#characters.append(character_button.character)
		#"TargetSelection":
			#for character_button: TargetButton in buttons.get_children():
				#characters.append(character_button.character)
	turn_queue.emit_signal("target_selected", characters)

func _reset_ui():
	for character_button in buttons.get_children():
		character_button.set_is_selected(false)
		character_button.focus_mode = Control.FOCUS_NONE
	focus_mode = Control.FOCUS_NONE
	buttons.focus_mode = Control.FOCUS_NONE
	_are_all_selected = false
	
func select_all_character():
	_are_all_selected = true
	for target_button in buttons.get_children():
		target_button.set_is_selected(true)
