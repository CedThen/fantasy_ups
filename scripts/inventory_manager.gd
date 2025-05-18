class_name InventoryManager extends Node


enum ItemType{ALL, QUEST, CONSUMABLE}

func _ready():
	Global.inventory_manager = self
	
	SignalBus.inventory_updated.connect(on_inventory_updated)
	pass


func setup():
	pass

func toggle_player_inventory():
	if %Inventory.visible:
		close_player_inventory()
	else:
		open_player_inventory()


func open_player_inventory():
	%Inventory.open()

func close_player_inventory():
	%Inventory.close()


func save():
	pass
	
func load():
	pass


func on_inventory_updated(data:InventoryData):
	%Inventory.update_inventory(data)
