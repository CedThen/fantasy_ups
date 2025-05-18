class_name Player extends Node

@export var current_location:Location		# Type TBD
@export var current_place:int				# Type TBD
var inventory:InventoryData


func _init() -> void:
	Global.player = self
	SignalBus.quest_completed.connect(on_quest_completed)
	SignalBus.quest_accepted.connect(on_quest_accepted)
	inventory = InventoryData.new()
	pass


func load_data() -> void:
	pass
	

func save_data() -> void:
	pass

func use_item(item_def:ItemDef, count:int = 1) -> bool:
	if not inventory.has_item(item_def):
		printerr("Missing item")
		return false
	
	if inventory.get_item(item_def).count >= count:
		inventory.remove_item(item_def, count)
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
		inventory.add_item(item_def, 1)
	
	
func on_quest_completed(quest:QuestInstance):
	# Give rewards
	for reward:ItemDef in quest.quest_def.rewards:
		var amt = quest.quest_def.rewards[reward]
		inventory.add_item(reward, amt)
		
