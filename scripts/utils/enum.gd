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
