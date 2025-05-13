extends Node

@onready var quest_manager: QuestManager = %QuestManager

var player:Player

func _ready() -> void:
	player = Player.new()
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
		var quest_def = params.get("quest_def_name")
		SignalBus.dialogic_quest_accepted.emit()
		pass
	pass
