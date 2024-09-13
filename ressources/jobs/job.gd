class_name Job extends Resource

@export var job_name: String
@export var actions: Array[ActionResource]

#key = character level - value list of stats
@export var stats_evolution: JSON

#var equipments_authorize: Array[Equipment]
