class_name Equipment extends Node

var equipment_name: String
var stats_upgraded: Stats

var attack_modifier: int
var defense_modifier: int
var magic_defense_modifier: int
var evade_modifier: int

var body_part: BODY_PART 

enum BODY_PART {
	HAND,
	HEAD,
	BODY,
	ARM,
}

enum ELEMENT {
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
	HOLY,
}

enum STATUS {
	POISON,
	PARALYSIS,
	CONFUSION,
	PETRIFY,
	SLEEP,
	TOAD,
	MINI,
	GRADUAL_PETRIFY,
}

class Weapon extends Equipment:
	var element: ELEMENT


class Armor extends Equipment:
	var elemental_resistance: Array[ELEMENT]
	var elemental_weakness: Array[ELEMENT]
	var statuses_immunity: Array[STATUS]

class Equipments:
	var left_hand: Equipment
	var right_hand: Equipment
	var head: Armor
	var body: Armor
	var arms: Armor
