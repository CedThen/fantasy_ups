class_name InventoryData 

var items:Dictionary[ItemDef, int]


func has_item(item_def:ItemDef) -> int:
	if items.has(item_def):
		return items[item_def]
		
	return 0


func add_item(item_def:ItemDef, count:int = 1):
	if items.has(item_def):
		items[item_def] += count
	else:
		items[item_def] = count

	print_inventory()


func remove_item(item_def:ItemDef, count:int = 1):
	items[item_def] -= count
	if items[item_def] == 0:
		items.erase(item_def)


func get_item_count(item_def:ItemDef) -> int:
	if items.has(item_def):
		return items[item_def]
		
	return 0


func print_inventory():
	print("INVENTORY")
	for item in items.keys():
		print(item.name + ":" + str(items[item]))
