class_name Enums

enum ELEMENT {
	NONE,
	FIRE,
	ICE,
	THUNDER,
	EARTH,
	HOLY
}

static func element_from_string(element_string: String) -> ELEMENT:
	match element_string:
		"NONE": 	return ELEMENT.NONE
		"FIRE": 	return ELEMENT.FIRE
		"ICE": 		return ELEMENT.ICE
		"THUNDER": 	return ELEMENT.THUNDER
		"EARTH": 	return ELEMENT.EARTH
		"HOLY": 	return ELEMENT.HOLY
		_: 			return ELEMENT.NONE

static func elements_from_string(elements_string: Array) -> Array[ELEMENT]:
	var elements: Array[ELEMENT] = []
	for element_string in elements_string:
		elements.append(element_from_string(element_string))
		
	return elements

enum TARGET {
	E,   #Single or Multiple targeting, default Enemy
	A,   #Single or Multiple targeting, default Ally
	SE,  #Single only, default Enemy
	SA,  #Single only, default Ally
	AE,  #Automatically targets all Enemies
	AA,  #Automatically targets all Allies
}

static func target_from_string(target_string: String) -> TARGET:
	match target_string:
		"E": 	return TARGET.E
		"A": 	return TARGET.A
		"SE": 	return TARGET.SE
		"SA": 	return TARGET.SA
		"AE": 	return TARGET.AE
		"AA": 	return TARGET.AA
		_: 		return TARGET.E

enum ABILITY_TYPE { 
	NONE,
	PHYSICAL,
	MAGICAL,
}

static func ability_type_from_string(ability_type_string: String) -> ABILITY_TYPE:
	match ability_type_string:
		"NONE": 	return ABILITY_TYPE.NONE
		"PHYSICAL": return ABILITY_TYPE.PHYSICAL
		"MAGICAL": 	return ABILITY_TYPE.MAGICAL
		_: 			return ABILITY_TYPE.NONE

enum STATUS {
	NONE,
	POISON,
	KO,
	SILENCE,
	SLEEP,
}

static func status_from_string(status_string: String) -> STATUS:
	match status_string:
		"POISON": 	return STATUS.POISON
		"KO": 		return STATUS.KO
		"SILENCE": 	return STATUS.SILENCE
		"SLEEP": 	return STATUS.SLEEP
		_: return STATUS.NONE

enum EQUIPMENT_TYPE{
	FISTS_AND_CLAWS,
	NUNCHUKS,
	RODS,
	STAVES,
	AXES_AND_HAMMERS,
	SPEARS,
	KNIVES,
	SWORDS,
	KATANAS,
	BOOKS,
	THROWING_WEAPONS,
	BELLS,
	HARPS,
	BOWS,
	ARROWS,
	SHIELDS,
	HEADGEAR,
	BODY_ARMOUR,
	ROBES,
	GLOVES,
	RINGS
}

static func equipment_type_from_string(element_string: String) -> EQUIPMENT_TYPE:
	
	var equipment_type: EQUIPMENT_TYPE
	match element_string:
		"FISTS_AND_CLAWS": equipment_type = EQUIPMENT_TYPE.FISTS_AND_CLAWS
		"NUNCHUKS": equipment_type = EQUIPMENT_TYPE.NUNCHUKS
		"RODS": equipment_type = EQUIPMENT_TYPE.RODS
		"STAVES": equipment_type = EQUIPMENT_TYPE.STAVES
		"AXES_AND_HAMMERS": equipment_type = EQUIPMENT_TYPE.AXES_AND_HAMMERS
		"SPEARS": equipment_type = EQUIPMENT_TYPE.SPEARS
		"KNIVES": equipment_type = EQUIPMENT_TYPE.KNIVES
		"SWORDS": equipment_type = EQUIPMENT_TYPE.SWORDS
		"KATANAS": equipment_type = EQUIPMENT_TYPE.KATANAS
		"BOOKS": equipment_type = EQUIPMENT_TYPE.BOOKS
		"THROWING_WEAPONS": equipment_type = EQUIPMENT_TYPE.THROWING_WEAPONS
		"BELLS": equipment_type = EQUIPMENT_TYPE.BELLS
		"HARPS": equipment_type = EQUIPMENT_TYPE.HARPS
		"BOWS": equipment_type = EQUIPMENT_TYPE.BOWS
		"ARROWS": equipment_type = EQUIPMENT_TYPE.ARROWS
		"SHIELDS": equipment_type = EQUIPMENT_TYPE.SHIELDS
		"HEADGEAR": equipment_type = EQUIPMENT_TYPE.HEADGEAR
		"BODY_ARMOUR": equipment_type = EQUIPMENT_TYPE.BODY_ARMOUR
		"ROBES": equipment_type = EQUIPMENT_TYPE.ROBES
		"GLOVES": equipment_type = EQUIPMENT_TYPE.GLOVES
		"RINGS": equipment_type = EQUIPMENT_TYPE.RINGS

	return equipment_type
