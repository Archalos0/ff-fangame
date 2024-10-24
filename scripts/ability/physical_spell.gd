class_name PhysicalSpell extends Spell

const TYPE: String = "PHYSICAL SPELL"

func exec(caster: Battler, targets: Array[Battler]):
	for target: Battler in targets:
		
		# Getting base damage
		var base_damage: int = caster.get_attack()
		
		# Apply bonuses and penalties 
		# Additive bonuses : HASTE & CHEER
		base_damage += caster.get_haste_attack_value()
		base_damage += caster.get_cheer_attack_value()
		
		# Elemental weaknesses of target
		if target.is_weak_against():
			base_damage *= 2
			
		# Vulnerability target
		if target.is_vulnerable():
			base_damage *= 2
		 
		# Elemental resistance of target
		if target.is_strong_against():
			base_damage /= 2
		
		# if caster is toad or mini
		if caster.is_toad() or caster.is_mini():
			base_damage = 0
		
		# Apply random range
		base_damage = randi_range(base_damage, base_damage*1.5)
		
		# Substract target defense
		var target_defense: int = target.get_defense()
		
		if target.is_ally(caster):
			target_defense = 0
		
		target_defense += target.get_safe_value()
		if target.is_defending():
			target_defense *= 4
			
		if target.is_vulnerable():
			target_defense = 0
		
		base_damage -= target_defense
		
		# Calculate net attack multiplier
		
		var attack_multiplier: int = caster.get_attack_multiplier()
		attack_multiplier += caster.get_haste_multiplier_value()
				
		var hit_percentage: int = caster.get_hit_percentage()
		
		if caster.is_on_back_row():
			hit_percentage /= 2
		
		if caster.is_blind():
			hit_percentage /= 2
			
		var defense_multiplier: int = target.get_defense_multiplier()
		# TODO: defense mutliplier on self targeting
		
		if target.is_ally(caster) and target.is_vulnerable():
			defense_multiplier = 0
			
		var evade_percentage: int = target.get_evade_percentage()
		
		var net_attack_multiplier: int = 0
		
		for i in range(attack_multiplier):
			if randi_range(1, 100) <= hit_percentage:
				net_attack_multiplier += 1
		
		for i in range(defense_multiplier):
			if randi_range(1, 100) <= evade_percentage:
				net_attack_multiplier -= 1
		
		var final_damage = base_damage * net_attack_multiplier
		
		# Multiply base damage with attack multiplier
		
		# Apply final damage bonuses ans penalties
		
