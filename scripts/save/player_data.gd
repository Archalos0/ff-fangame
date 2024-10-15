class_name PlayerData

var characters: CharactersData = CharactersData.new()
var capacity_points: int = 0

func load_player(dict: Dictionary):
	for key in dict.keys():
		match key:
			"characters": characters.load_characters(dict["characters"])
			"capacity_points": capacity_points =  dict["capacity_points"]
			
	
func get_properties_dict():
	var properties = {
		"characters": characters.get_properties_dict(),
		"capacity_points": capacity_points,
	}
	
	return properties
