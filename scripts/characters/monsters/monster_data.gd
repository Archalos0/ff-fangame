class_name MonsterData extends Node

var monster_name: String
var level: int

var stats: Stats
#var actions: Array[Action]

var gils: int
var experience: int

var sprite_frames: SpriteFrames

func load_monster(dict: Dictionary):
	monster_name = dict["name"]
	level = dict["level"]
	gils = dict["gil"]
	experience = dict["experience"]
	
	#stats = Stats.new()
	#stats.load_character_stats()
