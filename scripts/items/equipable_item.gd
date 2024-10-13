class_name EquipableItem extends Item

var equippable_by: Array[String]
var bonuses: Stats

# Weapon Data 
var attack_power: int
var hit_percentage: int
var status_inflicted: Enums.STATUS
var elements_inflicted: Array[Enums.ELEMENT]

# Armor Data
var defense: int
var evade_percentage: int
var magic_defense: int
var status_immunity: Array[Enums.STATUS]
var elemantal_resistances: Array[Enums.ELEMENT]
var elemental_weaknesses: Array[Enums.ELEMENT]
