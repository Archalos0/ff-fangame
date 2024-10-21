class_name ItemsBattleMenu extends Panel

signal spell_selected(spell: Spell)
signal cancel_item_selection()

@onready var buttons: GridContainer = $ScrollContainer/Buttons


const ITEM_BUTTON = preload("res://scenes/UI/item_button.tscn")

var _has_focus: bool = false

func set_focus_state(p_focus_state: bool): 
	_has_focus = p_focus_state
	
	if not _has_focus:
		for item_button: ItemButton in buttons.get_children():
			item_button.focus_mode = Control.FOCUS_NONE
		return
		
	for item_button: ItemButton in buttons.get_children():
		item_button.focus_mode = Control.FOCUS_ALL
	
	if buttons.get_child_count() > 0: buttons.get_child(0).grab_focus()

func load_items(p_items: Array[Item]):
	for item: Item in p_items:
		var item_button: ItemButton = ITEM_BUTTON.instantiate()
		item_button.load_item(item)
		item_button.item_selected.connect(Callable(self, "_on_item_selected"))
		item_button.cancel_item_selection.connect(Callable(self, "_on_item_selection_cancel"))
		buttons.add_child(item_button)

func _on_item_selected(item: Item) -> void:
	if (item is not ClassicItem or item is not EquipableItem) and item.spell_on_use == null:
		return 
	spell_selected.emit(item.spell_on_use)

func _on_item_selection_cancel():
	cancel_item_selection.emit()
