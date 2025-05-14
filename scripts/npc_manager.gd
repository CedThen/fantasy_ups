class_name NPCManager extends Node

var npc_defs:Array[NPCDef]

var npc_instances:Array[NPCInstance]	# SERIALIZED: not sure if this should get saved or diff data


func _init():
	load_npcs()
	generate_npcs()


func load_npcs():
	# Serialize in NPCS
	pass
	
	
func save_npcs():
	pass
	
	
func generate_npcs():
	for npc_def:NPCDef in npc_defs:
		var found:bool = false
		for npc:NPCInstance in npc_instances:
			if npc_def == npc.def:
				found = true
				break
				
		if found:
			continue
			
		var npc_instance:NPCInstance = NPCInstance.new(npc_def)
		npc_instances.append(npc_instance)


# Maybe called from map code for intial placement?
func make_instance():
	pass
