class_name PhysicalSpell extends Spell

const TYPE: String = "PHYSICAL SPELL"

func exec(caster: Battler, targets: Array[Battler]):
	for target: Battler in targets:
		target.get_hit(2)
	
