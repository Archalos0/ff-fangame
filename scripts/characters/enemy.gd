class_name Enemy extends Character

var gils: int
var experience: int

func load_from_character_resource(p_resource: CharacterResource):
	push_error("Need to implement from_character_resource() for enemy")

func load_actions():
	push_warning("Need to implement load_actions() for enemy")
	pass

func load_stats():
	push_warning("Need to implement load_stats() for enemy")
	pass
