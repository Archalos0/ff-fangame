class_name SpellCast

var spell: Spell = null
var targets: Array[Battler] = []


func cast(caster: Battler):
	if spell == null or targets.is_empty():
		return
	
	spell.exec(caster, targets)
	
