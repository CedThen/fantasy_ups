extends Node

@onready var quest_manager: QuestManager = %QuestManager

var player:Player

func _ready() -> void:
	player = Player.new()
	pick_up_random_quest()
	pass


func pick_up_random_quest():
	var quest_defs = quest_manager.get_eligible_quests()
	quest_defs.shuffle()
	quest_manager.serve_quest(quest_defs[0])
