class_name QuestManager extends Node

enum QuestStatus {NONE, ACTIVE, REJECTED, FAILED, COMPLETED}

# I think I need REQVAL simply so I can use a typed dictionary
enum ReqType {ITEM}


var quest_defs:Array[QuestDef]

var active_quests:Array[QuestInstance]

var pending_quest:QuestInstance		# The current quest that is in use for accepting/rejecting/completing


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


func check_reqs(reqs:Array) -> bool:
	var player:Player
	for req:ReqDef in reqs:
		if req.type == ReqDef.ReqType.NONE:
			continue
		
		var params:Dictionary = req.params
		if req.type == ReqDef.ReqType.ITEM:
			if params[ReqDef.ITEM_NAME] is not NPCDef:
				printerr(ReqDef.ITEM_NAME + " is not correct type for Item")
				continue
				
			var item_def:ItemDef = params[ReqDef.ITEM_NAME]
			var inequality:String = params[ReqDef.COMP]
			if not [">","<","="].has(inequality):
				printerr("INVALID INEQUALITY IN REQS FOR ITEM")
				continue
				
			if inequality == "<" and player.has_item(item_def) >= params[ReqDef.QTY]:
				return false
			elif inequality == ">" and player.has_item(item_def) <= params[ReqDef.QTY]:
				return false
			elif inequality == "=" and player.has_item(item_def) != params[ReqDef.QTY]:
				return false
			pass
		elif req.type == ReqDef.ReqType.AFFECTION:
			if params[ReqDef.NPC_NAME] is not NPCDef:
				printerr(ReqDef.NPC_NAME + " is not correct type for Affection")
				continue
				
			var npc_def:NPCDef = params[ReqDef.NPC_NAME]
			var npc:NPCInstance # Get Instance by Def
			var inequality:String = params[ReqDef.COMP]
			if not [">","<","="].has(inequality):
				printerr("INVALID INEQUALITY IN REQS FOR AFFECTION")
				continue
				
			if inequality == "<" and npc.affection >= params[ReqDef.QTY]:
				return false
			elif inequality == ">" and npc.affection <= params[ReqDef.QTY]:
				return false
			elif inequality == "=" and npc.affection != params[ReqDef.QTY]:
				return false
			pass
			
	return true


func check_eligible(quest_def:QuestDef) -> bool:
	if check_reqs(quest_def.eligible_reqs):
		return true
			
	return true
	

func check_quest_complete():
	var current_time:int = 0
	var player:Player = null
	for quest:QuestInstance in active_quests:
		if quest.status == QuestManager.QuestStatus.COMPLETED:
			continue
		
		if quest.expiry_time > current_time:
			# too late
			pass
		
		var quest_def:QuestDef = quest.quest_def
		if quest_def.dest_place_of_interest and quest_def.dest_place_of_interest != player.current_place:
			continue
			
		if quest_def.dest_place_of_interest != player.current_place:
			continue
		
		var has_all_reqs = true
		if not check_reqs(quest_def.complete_reqs):
			continue
		
		# At the current location/place and have everything needed, and done in time
		if quest_def.complete_timeline:
			pending_quest = quest
			Dialogic.start(quest_def.complete_timeline)
		else:
			complete_quest(quest)
		return
	

# return a list of eligible for a ... location? point of interest?
func get_eligible_quests() -> Array[QuestDef]:
	var ret:Array[QuestDef]
	for quest_def:QuestDef in quest_defs:
		if check_eligible(quest_def):
			ret.append(quest_def)
			
	return ret


# Auto trigger when starting a quest line and at that location?
func serve_quest(quest_def:QuestDef) -> void:
	var quest = QuestInstance.new(quest_def)
	pending_quest = quest
	
	Dialogic.start(quest.quest_def.start_timeline)


func accept_quest() -> void:
	print("Accepting Quest:" + pending_quest.quest_def.title)
	active_quests.append(pending_quest)
	SignalBus.quest_accepted.emit(pending_quest)
	pending_quest = null


func complete_quest(quest:QuestInstance):
	print("Hooray! You've completed the quest")
	SignalBus.quest_completed.emit(quest)

	

# Funcs to be triggered from Dialogic signals
func on_quest_accepted() -> void:
	accept_quest()
	pass
	
	
func on_quest_rejected() -> void:
	# reject
	# Don't know if I need this, but maybe, if we want to say reject but can't restart?
	pass
