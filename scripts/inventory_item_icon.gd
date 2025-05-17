class_name InventoryItemIcon extends ColorRect

signal icon_pressed(InventoryItemIcon)

func _on_gui_input(event: InputEvent) -> void:
	icon_pressed.emit(self)
	pass # Replace with function body.
