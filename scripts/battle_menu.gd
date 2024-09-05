class_name BattleMenu extends Control

@onready var attack_button: ActionButton = $ActionSelection/VBoxContainer/AttackButton
@onready var defend_button: ActionButton = $ActionSelection/VBoxContainer/DefendButton
@onready var escape_button: ActionButton = $ActionSelection/VBoxContainer/EscapeButton
@onready var heal_button: ActionButton = $ActionSelection/VBoxContainer/HealButton

#@onready var stats: StatsUI = $Informations/CharacterData/Stats
#@onready var character_name: Label = $Informations/CharacterData/CharacterName

@onready var action_selection: MenuHandler = $ActionSelection
@onready var target_selection: MenuHandler = $TargetSelection
@onready var player_character_informations: PlayerSelectionMenu = $PlayerCharacterInformations


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = MOUSE_FILTER_PASS 

func update_actions_buttons(actions: Array[Action]):
	attack_button.set_action(actions[0])
	defend_button.set_action(actions[1])
	escape_button.set_action(actions[2])
	heal_button.set_action(actions[3])

func set_focus_on_target_selection():
	target_selection.get_focus()
	action_selection.lost_focus()
	player_character_informations.lost_focus()
	
func set_focus_on_action_selection():
	action_selection.get_focus()
	target_selection.lost_focus()
	player_character_informations.lost_focus()	

func set_focus_on_player_character():
	player_character_informations.get_focus()
	target_selection.lost_focus()
	action_selection.lost_focus()

#func set_character_name(character):
	#character_name.text = character.character_name

#func set_stats(character: Character):
	#stats.set_stat(stats.STAT.HP, character.stats.health)
	#stats.set_stat(stats.STAT.MP, character.stats.magic_point)
	#stats.set_stat(stats.STAT.STR, character.stats.strenght)
	#stats.set_stat(stats.STAT.MAG, character.stats.magic)
	#stats.set_stat(stats.STAT.DEF, character.stats.defense)
	#stats.set_stat(stats.STAT.MDEF, character.stats.magic_defense)
	#stats.set_stat(stats.STAT.AGI, character.stats.agility)
	#stats.set_stat(stats.STAT.ACC, character.stats.accuracy)
	#stats.set_stat(stats.STAT.EVA, character.stats.evasion)
	#stats.set_stat(stats.STAT.LUC, character.stats.luck)
