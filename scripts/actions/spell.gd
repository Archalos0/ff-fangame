extends Node

enum ELEMENT {
	FIRE,
	ICE,
	LIGHTNING,
	EARTH,
	WIND,
}

enum AFFLICTION {
	POISON,
	SLEEP,
	BLIND,
	PETRIFICATION,
	PARALYSIS,
	CONFUSION,
	SILENCE,
}

class Spell:
	var element: ELEMENT
	var power: int
	var affliction: Array[AFFLICTION]
