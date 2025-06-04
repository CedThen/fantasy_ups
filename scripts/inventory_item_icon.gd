class_name InventoryItemIcon extends ColorRect

var item:Item		#Item in InventoryData this icon represents

signal icon_pressed(InventoryItemIcon)


func set_count_label(count:int):
	%CountLabel.text = str(count)


func _on_gui_input(event: InputEvent) -> void:
	print("BLAH ITEM")
	icon_pressed.emit(self)
