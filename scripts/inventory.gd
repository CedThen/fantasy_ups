class_name Inventory extends PanelContainer

@export var inventory_slot_scene:PackedScene
@export var inventory_item_icon_scene:PackedScene
@export var num_slots:int = 32

@onready var slots: GridContainer = %Slots

var slots_scenes:Array[InventorySlot]

var picked_up_slot:InventorySlot
var hovered_slot:InventorySlot
var holding_icon:InventoryItemIcon

func _ready() -> void:
	var inventory_item_icon = inventory_item_icon_scene.instantiate()
	for a in range(0, num_slots):
		var slot:InventorySlot = inventory_slot_scene.instantiate()
		slot.item_picked_up.connect(on_item_picked_up)
		slot.item_put_down.connect(on_item_put_down)
		slot.item_slot_entered.connect(on_item_slot_entered)
		slot.item_slot_exited.connect(on_item_slot_exited)
		slot.id = str(a)
		slots.add_child(slot)
		slots_scenes.append(slot)
			
	add_icon_to_slot(4, inventory_item_icon)

func toggle(data:InventoryData):
	if not visible:
		open()
	else:
		close()
	

func open():
	show()
	pass
	

func close():
	hide()
	pass

	
	
func add_icon_to_slot(slot_index:int, icon:InventoryItemIcon) -> void:
	slots_scenes[slot_index].add_icon(icon)
	pass


func on_item_picked_up(from_slot:InventorySlot, item_icon:InventoryItemIcon):
	holding_icon = item_icon
	
	picked_up_slot = from_slot
	pass


func on_item_put_down(item_icon:InventoryItemIcon):
	if hovered_slot:
		hovered_slot.add_icon(item_icon)
	elif picked_up_slot:
		picked_up_slot.add_icon(item_icon)
	picked_up_slot = null
	pass


func on_item_slot_entered(slot:InventorySlot):
	hovered_slot = slot


func on_item_slot_exited(slot:InventorySlot):
	hovered_slot = null
