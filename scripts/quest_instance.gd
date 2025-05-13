class_name QuestInstance

var quest_def:QuestDef

var status:QuestManager.QuestStatus = QuestManager.QuestStatus.NONE
var time_remaining:int = -1


func _init(def:QuestDef) -> void:
	quest_def = def
	status = QuestManager.QuestStatus.ACTIVE
	time_remaining = quest_def.get_duration()
