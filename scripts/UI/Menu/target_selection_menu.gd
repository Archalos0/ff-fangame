class_name TargetSelectionMenu extends CharacterMenuHandler

const TARGET_BUTTON = preload("res://scenes/UI/target_button.tscn")

func load_characters(p_enemies: Array[Battler]) -> void:
	for enemy in p_enemies:
		var target_button = TARGET_BUTTON.instantiate()
		target_button.set_character(enemy)
		_buttons.add_child(target_button)
	super(p_enemies)
