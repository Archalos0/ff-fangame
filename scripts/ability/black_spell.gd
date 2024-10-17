class_name BlackSpell extends Spell

const TYPE: String = "BLACK MAGIC"

func exec(caster: Battler, targets: Array[Battler]):
	for target: Battler in targets:
		target.get_hit(3)
	
