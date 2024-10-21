class_name ItemButton extends CommandButton

signal item_selected(item: Item)
signal cancel_item_selection()

var item: Item


func _ready() -> void:
	initialize()
	
func set_action(new_item: Item):
	if new_item == null:
		item = null
		text = ""
	else:
		item = new_item
		text = item.item_name
	
func _on_focus_entered() -> void:
	on_focus_entered()

func _on_focus_exited() -> void:
	on_focus_exited()
	
func _on_resized() -> void:
	on_resized()

func _on_button_up() -> void:
	item_selected.emit(item)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("Cancel"):
			cancel_item_selection.emit()
