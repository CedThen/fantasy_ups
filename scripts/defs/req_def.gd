@tool
class_name ReqDef extends Resource

enum ReqType{
	NONE,				
	ITEM,				# [item_name, qty]
	AFFECTION,			# [npc_name, [>|<|=], val]
	VAR					# [var_name, [>|<|=], val]
}

const ITEM_NAME = "item"
const NPC_NAME = "npc"
const VAR_NAME = "var"
const QTY = "qty"
const VAL = "val"
const COMP = "comp"

@export var type:ReqType = ReqType.NONE :
	set(val):
		params.clear()
		if val == ReqType.NONE:
			pass
		elif val == ReqType.ITEM:
			params[ITEM_NAME] = ItemDef
			params[COMP] = ">|<|="
			params[QTY] = 0
		elif val == ReqType.AFFECTION:
			params[NPC_NAME] = NPCDef
			params[COMP] = ">|<|="
			params[VAL] = 0
		elif val == ReqType.VAR:
			params[VAR_NAME] = "VariableName"
			params[COMP] = ">|<|="
			params[VAL] = 0
		type = val
		
@export var params:Dictionary		# Setup based on type
