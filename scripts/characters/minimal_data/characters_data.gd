class_name CharactersData

var character_1: CharacterData = CharacterData.new()
var character_2: CharacterData = CharacterData.new()
var character_3: CharacterData = CharacterData.new()
var character_4: CharacterData = CharacterData.new()

#Set up the default name of the characters
func _init() -> void:
	character_1.character_name = "Luneth" 
	character_2.character_name = "Arc" 
	character_3.character_name = "Refia" 
	character_4.character_name = "Ingus" 

func load_characters(characters: Array):
	characters.resize(4)
	for character in characters:
		if character == null:
			character = CharacterData.new()
			
	if characters[0] != null : character_1.load_character(characters[0])
	if characters[1] != null : character_2.load_character(characters[1])
	if characters[2] != null : character_3.load_character(characters[2])
	if characters[3] != null : character_4.load_character(characters[3])

func get_properties_dict():
	var properties = [
		character_1.get_properties_dict(),
		character_2.get_properties_dict(),
		character_3.get_properties_dict(),
		character_4.get_properties_dict(),
	]
	
	return properties
