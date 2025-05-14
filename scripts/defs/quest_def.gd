class_name QuestDef extends Resource

@export var title:String
@export var desc:String
@export var quest_box:bool
@export var start_npc:NPCDef
@export var eligible_reqs:Array[ReqDef]			# List of Reqs to be eligible for quest
@export var start_timeline:DialogicTimeline			# Dialogic timeline name to play when being served quest

@export var quest_items:Array[ItemDef]		# items picked up when accepting quest

@export var end_npc:NPCDef
@export var dest_location:LocationDef				# Type TBD
@export var dest_place_of_interest:int 		# Type TBD
@export var duration:int					# Time limit to complete the quest
@export var complete_reqs:Array[ReqDef]		# List of Reqs to check for quest completion
@export var complete_timeline:DialogicTimeline		# Dialogic timeline name to play when completing quest

# Should probably define actual reward/item types for things like rewads, or quest reqs
@export var rewards:Dictionary[ItemDef, int]


func get_duration() -> int:
	return duration
