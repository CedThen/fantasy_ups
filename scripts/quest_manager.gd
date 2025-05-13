class_name QuestManager extends Node

enum QuestStatus {NONE, ACTIVE, REJECTED, FAILED, COMPLETED}
enum ReqType {ITEM, DURATION}
enum ReqVal {STRING, TIME}

var quest_defs:Array[QuestDef]

var pending_quest:QuestDef		# The current quest that is in use for accepting/completing


func _init() -> void:
	SignalBus.dialogic_quest_accepted.connect(on_quest_accepted)
	SignalBus.dialogic_quest_rejected.connect(on_quest_rejected)
	load_all_quests()
	pass
	
	
func load_all_quests() -> void:
	var path:String = "res://assets/quests/"
	var quest_dir = DirAccess.open(path)

	if quest_dir:
		quest_dir.list_dir_begin()
		var file_name = quest_dir.get_next()

		while file_name != "":
			if not quest_dir.current_is_dir() and file_name.ends_with(".tres"):
				var full_path = path.path_join(file_name)
				var quest = load(full_path)
				if quest:
					quest_defs.append(quest)
					
			file_name = quest_dir.get_next()
			
		quest_dir.list_dir_end()
	else:
		push_error("Failed to open directory: " + path)


func check_eligible(quest_def:QuestDef) -> bool:
	for req_key in quest_def.eligible_reqs:
		if req_key == QuestManager.ReqType.ITEM:
			var key_item  = quest_def.eligible_reqs[req_key]
			# check if player owns key_item
			return false
		elif req_key == QuestManager.ReqType.DURATION:
			var time  = quest_def.eligible_reqs[req_key]
			return false
			
	return true
	

# return a list of eligible for a ... location? point of interest?
func get_eligible_quests() -> Array[QuestDef]:
	var ret:Array[QuestDef]
	for quest_def:QuestDef in quest_defs:
		if check_eligible(quest_def):
			ret.append(quest_def)
			
	return ret


# Auto trigger when starting a quest line and at that location?
func serve_quest(quest_def:QuestDef) -> void:
	pending_quest = quest_def
	
	# TODO: Start Dialogic Tree
	Dialogic.start(pending_quest.timeline_name)
	


func accept_quest() -> void:
	var quest_instance = QuestInstance.new(pending_quest)
	print("Accepting Quest:" + quest_instance.quest_def.title)
	
	pending_quest = null
	

# Funcs to be triggered from Dialogic signals
func on_quest_accepted() -> void:
	accept_quest()
	pass
	
	
func on_quest_rejected() -> void:
	# reject
	pass
