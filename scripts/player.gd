class_name Player extends Node

@export var current_location:Location		# Type TBD
@export var current_place:int				# Type TBD
var inventory:Dictionary[ItemDef, int]			# Type TBD


func _init() -> void:
	SignalBus.quest_completed.connect(on_quest_completed)
	SignalBus.quest_accepted.connect(on_quest_accepted)
	pass


func load_data() -> void:
	pass
	

func save_data() -> void:
	pass


func has_item(item_def:ItemDef) -> int:
	if inventory.has(item_def):
		return inventory[item_def]
		
	return 0


func add_item(item_def:ItemDef, count:int = 1):
	if inventory.has(item_def):
		inventory[item_def] += count
	else:
		inventory[item_def] = count

	print("Added " + str(count) + " " + item_def.name + " to your inventory")
	print_inventory()


func use_item(item_def:ItemDef, count:int = 1) -> bool:
	if not has_item(item_def):
		printerr("Missing item")
		return false
	
	if inventory[item_def] >= count:
		inventory[item_def] -= count
		if inventory[item_def] == 0:
			inventory.erase(item_def)
	else:
		printerr("Not enough of item")
		return false
	
	return true


func entered_location(dest_location:Location):
	current_location = dest_location
	print("Player just entered:" + current_location.location_def.name)
	SignalBus.player_location_updated.emit()


# Signals emitted from QuestManager
func on_quest_accepted(quest:QuestInstance):
	# Pick up quest items
	for item_def in quest.quest_def.quest_items:
		add_item(item_def, 1)
	
	
func on_quest_completed(quest:QuestInstance):
	# Give rewards
	for reward:ItemDef in quest.quest_def.rewards:
		var amt = quest.quest_def.rewards[reward]
		add_item(reward, amt)
		

func print_inventory():
	print("INVENTORY")
	for item in inventory.keys():
		print(item.name + ":" + str(inventory[item]))
