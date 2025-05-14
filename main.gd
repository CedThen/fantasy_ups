extends Node

@onready var quest_manager: QuestManager = %QuestManager

@export var player:Player

var time:int		# Some global time? in game time, hours? minutes?

func _ready() -> void:
	player = Player.new()
	Global.player = player
	
	# Temp
	var coin_def = load("res://assets/items/coin.tres")
	player.add_item(coin_def)

	# Test picking up a quest
	pick_up_random_quest()
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	pass


func pick_up_random_quest():
	var quest_defs = quest_manager.get_eligible_quests()
	quest_defs.shuffle()
	quest_manager.serve_quest(quest_defs[0])


# For dialogic to send signals generically back
# params in the form of "cmd":[Command name], [contextual val]:[val]
func _on_dialogic_signal(params:Dictionary):
	var cmd = params.get("cmd")
	if cmd == "accept_quest":
		#var quest_def = params.get("quest_def_name")
		SignalBus.dialogic_quest_accepted.emit()
		pass
	pass
