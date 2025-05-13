class_name QuestDef extends Resource


@export var title:String
@export var desc:String
@export var eligible_reqs:Dictionary[QuestManager.ReqType, QuestManager.ReqVal] #  list of requirments to be eligible
@export var timeline_name:DialogicTimeline		# Dialogic timeline name to play

@export var location:int				# Type TBD
@export var point_of_interest:int 		# Type TBD
@export var duration:int				# Time limit to complete the quest
@export var complete_reqs:Dictionary 	# things for the quest to be successful



func get_duration() -> int:
	return duration
