class_name InventorySlot extends PanelContainer

signal item_picked_up(from_slot:InventorySlot, item_icon:InventoryItemIcon, g_pos,Vector2)
signal item_put_down(item_icon:InventoryItemIcon)
signal item_slot_entered(slot:InventorySlot)
signal item_slot_exited(slot:InventorySlot)
signal item_moved(g_pos:Vector2)

var id:String = ""
var occupied:bool = false
var icon:InventoryItemIcon = null
var moving_icon:bool = false

var touch_offset:Vector2

func has_icon() -> bool:
	return icon != null


func add_icon(icon:InventoryItemIcon):
	if self.icon:
		printerr("Trying to add icon to slot that has icon:" + str(self.icon))
		return
	self.icon = icon
	add_child(icon)
	occupied = true
	

func remove_icon() -> InventoryItemIcon:
	occupied = false
	if not icon:
		printerr("Trying to remove icon with no icon:")
		return
	var tmp = icon
	remove_child(icon)
	self.icon = null
	return tmp
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if icon:
				remove_child(icon)
				touch_offset = event.position
				var pos = event.global_position-touch_offset+icon.position*2	# why *2?
				item_picked_up.emit(self, icon, pos)
				moving_icon = true
				print(event)
		elif not event.pressed:
			if icon:
				var tmp := icon
				icon = null
				item_put_down.emit(tmp)
				moving_icon = false
				occupied = false
	elif event is InputEventMouseMotion:
		if moving_icon:
			item_moved.emit(event.global_position-touch_offset)



func _on_mouse_entered() -> void:
	self.modulate.a = 0.5
	item_slot_entered.emit(self)


func _on_mouse_exited() -> void:
	item_slot_exited.emit(self)
	self.modulate.a = 1.0
