class_name TargetSelectionMenu extends CharacterMenuHandler

const TARGET_BUTTON = preload("res://scenes/UI/target_button.tscn")

func load_characters(p_enemies: Array[Battler]) -> void:
	for enemy in p_enemies:
		var target_button = TARGET_BUTTON.instantiate()
		target_button.set_character(enemy)
		_buttons_list._buttons.append(target_button)
	super(p_enemies)
	_load_ui()
	#for enemy in p_enemies:
		#var target_button = TARGET_BUTTON.instantiate()
		#target_button.set_character(enemy)
		#_buttons.add_child(target_button)
	#super(p_enemies)

func _load_ui():
	for _button: CommandButton in _buttons_list._buttons:
		_containers_list[0].add_child(_button)
