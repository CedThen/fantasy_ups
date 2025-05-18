class_name Inventory extends VBoxContainer

@export var inventory_slot_scene:PackedScene
@export var inventory_item_icon_scene:PackedScene
@export var num_slots:int = 32

@onready var slots: GridContainer = %Slots

var inventory_name:String = "Items"
var inventory_type:InventoryManager.ItemType = InventoryManager.ItemType.ALL

var slots_scenes:Array[InventorySlot]

var picked_up_slot:InventorySlot
var hovered_slot:InventorySlot
var picked_up_icon:InventoryItemIcon

var next_empty_slot:int = 0


func _ready() -> void:
	var inventory_item_icon = inventory_item_icon_scene.instantiate()
	for a in range(0, num_slots):
		var slot:InventorySlot = inventory_slot_scene.instantiate()
		slot.item_picked_up.connect(on_item_picked_up)
		slot.item_put_down.connect(on_item_put_down)
		slot.item_slot_entered.connect(on_item_slot_entered)
		slot.item_slot_exited.connect(on_item_slot_exited)
		slot.item_moved.connect(on_item_moved)
		slot.id = str(a)
		slots.add_child(slot)
		slots_scenes.append(slot)
	

func update_inventory(inv:InventoryData = null, refresh:bool = false):
	if not inv:
		return

	for inventory_slot:InventorySlot in slots_scenes:
		if inventory_slot.has_icon():
			inventory_slot.remove_icon()
		
	for item:Item in inv.items:
		var inventory_item_icon = inventory_item_icon_scene.instantiate()
		var slot_index = get_next_empty_slot()
		add_icon_to_slot(slot_index, inventory_item_icon, item)


func open():
	show()
	%DescHolder.modulate.a = 0.0


func close():
	hide()


func get_next_empty_slot() -> int:
	for a in range(0, slots_scenes.size()):
		if not slots_scenes[a].occupied:
			return a
			
	return -1

	
func add_icon_to_slot(slot_index:int, icon:InventoryItemIcon, item) -> void:
	slots_scenes[slot_index].add_icon(icon)
	icon.item = item


func on_item_picked_up(from_slot:InventorySlot, item_icon:InventoryItemIcon, g_pos:Vector2):
	picked_up_icon = item_icon
	picked_up_slot = from_slot
	%ItemHeldHolder.add_child(picked_up_icon)
	picked_up_icon.global_position = g_pos - %ItemHeldHolder.position


func on_item_put_down(item_icon:InventoryItemIcon):
	%ItemHeldHolder.remove_child(item_icon)
	if hovered_slot:
		if hovered_slot.has_icon():
			var swap_icon = hovered_slot.remove_icon()
			hovered_slot.add_icon(item_icon)
			picked_up_slot.add_icon(swap_icon)
			pass
		else:
			hovered_slot.add_icon(item_icon)
	elif picked_up_slot:
		picked_up_slot.add_icon(item_icon)
	picked_up_slot = null


func on_item_slot_entered(slot:InventorySlot):
	hovered_slot = slot
	if slot.has_icon():
		%DescHolder.modulate.a = 1.0
		%Desc.text = slot.icon.item.def.desc
	


func on_item_slot_exited(slot:InventorySlot):
	hovered_slot = null
	%DescHolder.modulate.a = 0.0


func on_item_moved(g_pos:Vector2):
	picked_up_icon.global_position = g_pos
