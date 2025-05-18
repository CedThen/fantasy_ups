class_name InventoryData 

#var items:Dictionary[ItemDef, int]
var items:Array[Item]


func setup():
	pass


func has_item(item_def:ItemDef) -> int:
	for item:Item in items:
		if item.def == item_def:
			return item.count
		
	return 0


func get_item(item_def:ItemDef) -> Item:
	for item:Item in items:
		if item.def == item_def:
			return item
	return null
	

func add_item(item_def:ItemDef, count:int = 1):
	var item = get_item(item_def)
	if item:
		item.count += count
	else:
		var new_item:Item = Item.new(item_def)
		new_item.count = count
		items.append(new_item)

	SignalBus.inventory_updated.emit(self)


func remove_item(item_def:ItemDef, count:int = 1):
	var item = get_item(item_def)
	item.count -= count
	if item.count < 0:
		for i:Item in items:
			if i.def != item.def:
				continue
				
			items.erase(i)
	
	SignalBus.inventory_updated.emit(self)


func get_inventory_items(item_type:InventoryManager.ItemType) -> Array[Item]:
	var ret:Array[Item]
	for item:Item in items:
		if item.def.item_type == item_type:
			ret.append(item)
		
	return ret


func print_inventory():
	print("INVENTORY")
	for item:Item in items:
		print(item.def.name + ":" + str(item.count))
