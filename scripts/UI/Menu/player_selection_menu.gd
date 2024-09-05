class_name PlayerSelectionMenu extends CharacterMenuHandler

const CHARACTER_INFORMATIONS = preload("res://scenes/UI/character_informations.tscn")


func load_characters(p_player_characters: Array[Character]):
	super(p_player_characters)
	for character in characters:
		var characterDataUI = CHARACTER_INFORMATIONS.instantiate()
		v_box_container.add_child(characterDataUI)
		characterDataUI.h_box_container.custom_minimum_size = Vector2(0,50)
		characterDataUI.set_character(character)