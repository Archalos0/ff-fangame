class_name Character

var character_name: String
var level: int

var _sprite_frames: SpriteFrames

func get_animation():
	push_error("The method get_animation() has not been implementing in the derived class")

func get_stats() -> Stats:
	push_error("The method get_stats() has not been implementing in the derived class")
	return null

func get_combat_stats() -> CombatStats:
	push_error("The method get_combat_stats() has not been implementing in the derived class")
	return null

func get_sprite_frames() -> SpriteFrames:
	push_error("The method get_sprite_frames() has not been implementing in the derived class")
	return

func get_actions() -> Array[Action]:
	push_error("The method get_actions() has not been implementing in the derived class")
	return []

func get_spells() -> Magics:
	push_error("The method get_spells() has not been implementing in the derived class")
	return null
