class_name InventorySlot extends PanelContainer

signal item_picked_up(from_slot:InventorySlot, item_icon:InventoryItemIcon)
signal item_put_down(item_icon:InventoryItemIcon)
signal item_slot_entered(slot:InventorySlot)
signal item_slot_exited(slot:InventorySlot)

var id:String = ""
var occupied:bool = false
var icon:InventoryItemIcon = null


func add_icon(icon:InventoryItemIcon):
	self.icon = icon
	add_child(icon)
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if icon:
				item_picked_up.emit(self, icon)
		elif not event.pressed:
			if icon:
				var tmp := icon
				remove_child(icon)
				icon = null
				item_put_down.emit(tmp)


func _on_mouse_entered() -> void:
	self.modulate.a = 0.5
	item_slot_entered.emit(self)


func _on_mouse_exited() -> void:
	item_slot_exited.emit(self)
	self.modulate.a = 1.0
