class_name MagicSpellsMenu extends Panel

signal spell_selected(spell: Spell)
signal cancel_action()

@onready var level_1: HBoxContainer = $ScrollContainer/List/Level1
@onready var level_2: HBoxContainer = $ScrollContainer/List/Level2
@onready var level_3: HBoxContainer = $ScrollContainer/List/Level3
@onready var level_4: HBoxContainer = $ScrollContainer/List/Level4
@onready var level_5: HBoxContainer = $ScrollContainer/List/Level5
@onready var level_6: HBoxContainer = $ScrollContainer/List/Level6
@onready var level_7: HBoxContainer = $ScrollContainer/List/Level7
@onready var level_8: HBoxContainer = $ScrollContainer/List/Level8

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var list: VBoxContainer = $ScrollContainer/List

var _has_focus: bool = false

func _send_spell() -> void:
	#var buttons_selected: Array[CommandButton] = _buttons.get_buttons_selected()
	#if buttons_selected.size() == 0:
		#push_error("Pas de spell sélectionné")
		#return
	#
	#if buttons_selected.size() > 1:
		#push_error("Plus d'un spell sélectionné")
		#return
	#
	#spell_selected.emit(buttons_selected[0].spell)
	pass
	
func load_spells(magics: Magics) -> void:
	
	level_1.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_1.slot_1)
	level_1.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_1.slot_2)
	level_1.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_1.slot_3)
	
	level_2.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_2.slot_1)
	level_2.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_2.slot_2)
	level_2.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_2.slot_3)
	
	level_3.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_3.slot_1)
	level_3.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_3.slot_2)
	level_3.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_3.slot_3)
	
	level_4.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_4.slot_1)
	level_4.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_4.slot_2)
	level_4.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_4.slot_3)
	
	level_5.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_5.slot_1)
	level_5.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_5.slot_2)
	level_5.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_5.slot_3)
	
	level_6.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_6.slot_1)
	level_6.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_6.slot_2)
	level_6.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_6.slot_3)
	
	level_7.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_7.slot_1)
	level_7.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_7.slot_2)
	level_7.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_7.slot_3)
	
	level_8.get_node("Buttons").get_node("FirstSlot").set_spell(magics.level_8.slot_1)
	level_8.get_node("Buttons").get_node("SecondSlot").set_spell(magics.level_8.slot_2)
	level_8.get_node("Buttons").get_node("ThirdSlot").set_spell(magics.level_8.slot_3)
	

func reset_spells():
	level_1.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_1.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_1.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_2.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_2.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_2.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_3.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_3.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_3.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_4.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_4.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_4.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_5.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_5.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_5.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_6.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_6.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_6.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_7.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_7.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_7.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
	level_8.get_node("Buttons").get_node("FirstSlot").set_spell(null)
	level_8.get_node("Buttons").get_node("SecondSlot").set_spell(null)
	level_8.get_node("Buttons").get_node("ThirdSlot").set_spell(null)
	
func set_focus_state(p_focus_state: bool) -> void:
	_has_focus = p_focus_state
	
	if not _has_focus:
		for level in list.get_children():
			for spell_button: SpellButton in level.get_node("Buttons").get_children():
				spell_button.focus_mode = Control.FOCUS_NONE
			
		return
	
	for level in list.get_children():
		for spell_button: SpellButton in level.get_node("Buttons").get_children():
				spell_button.focus_mode = Control.FOCUS_ALL
	
	level_1.get_node("Buttons").get_child(0).grab_focus()

func _on_spell_button_up(spell: Spell) -> void:
	if spell == null: return
	
	spell_selected.emit(spell)


func _on_cancel_action() -> void:
	cancel_action.emit()
