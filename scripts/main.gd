extends Node

@onready var quest_manager: QuestManager = %QuestManager
@onready var world_map: WorldMap = %WorldMap

@export var player:Player

var time:int # Some global time? in game time, hours? minutes?

func _ready() -> void:
	player = Player.new()
	Global.player = player
	
	# Temp
	var coin_def = load("res://assets/items/coin.tres")
	player.inventory.add_item(coin_def)

	player.entered_location(world_map.get_starting_location())	
	
	
	SignalBus.player_location_updated.connect(on_player_location_updated)
	
	# Connect HUD
	SignalBus.calendar_pressed.connect(on_calendar_pressed)
	SignalBus.quest_box_pressed.connect(on_quest_box_pressed)
	SignalBus.journal_pressed.connect(on_journal_pressed)
	SignalBus.quest_log_pressed.connect(on_quest_log_pressed)
	SignalBus.location_map_pressed.connect(on_location_map_pressed)
	SignalBus.world_map_pressed.connect(on_world_map_pressed)
	SignalBus.inventory_pressed.connect(on_inventory_pressed)
	
	# Connect Dialogic Generic signal
	Dialogic.signal_event.connect(_on_dialogic_signal)

	
	#Dialogic.start("intro_1")
	pass


func on_player_location_updated():
	quest_manager.check_quest_complete()
	
	var quest_defs = quest_manager.get_eligible_quests()
	if quest_defs.size() > 0:
		quest_defs.shuffle()
		quest_manager.serve_quest(quest_defs[0])


# HUD Calls
func on_calendar_pressed():
	pass


func on_quest_box_pressed():
	var quest_defs = quest_manager.get_eligible_quests(true)
	if quest_defs.size() > 0:
		quest_defs.shuffle()
		quest_manager.serve_quest(quest_defs[0])


func on_inventory_pressed():
	%Inventory.toggle(player.inventory)
	pass
	
func on_journal_pressed():
	pass
	
func on_quest_log_pressed():
	pass
	
func on_location_map_pressed():
	pass
	
func on_world_map_pressed():
	pass

# For dialogic to send signals generically back
# params in the form of "cmd":[Command name], [contextual val]:[val]
func _on_dialogic_signal(params:Dictionary):
	var cmd = params.get("cmd")
	if cmd == "accept_quest":
		SignalBus.dialogic_quest_accepted.emit()
		pass
	elif cmd == "complete_quest":
		SignalBus.dialogic_quest_completed.emit()
		pass
	pass
