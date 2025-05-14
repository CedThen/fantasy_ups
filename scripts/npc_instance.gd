class_name NPCInstance extends Resource

var def:NPCDef

var location
var place
var affection:int


func _init(npc_def:NPCDef):
	def = npc_def
	affection = def.initial_affection
	
	
func change_affection(amt:int):
	affection += amt
