class_name NPCDef extends Resource

# Experimental - need to determine what stats exist here vs dialogic and how they influence each other

var name_id:String 		# will be the file name
@export var title:String
@export var name:String
@export var dialogic_char:DialogicCharacter

@export var initial_affection:int = 0		# positive friendly, negative dislike?
