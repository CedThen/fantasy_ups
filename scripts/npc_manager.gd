class_name NPCManager extends Node

var npc_defs:Array[NPCDef]

var npc_instances:Array[NPCInstance]	# SERIALIZED: not sure if this should get saved or diff data


func _init():
	load_all_npc_defs()
	load_npcs()
	generate_npcs()


func load_npcs():
	# Serialize in NPCS
	pass
	
	
func save_npcs():
	pass


func load_all_npc_defs():
	var path:String = "res://assets/npcs/"
	var npcs_dir = DirAccess.open(path)

	if npcs_dir:
		npcs_dir.list_dir_begin()
		var file_name = npcs_dir.get_next()

		while file_name != "":
			if not npcs_dir.current_is_dir() and file_name.ends_with(".tres"):
				var full_path = path.path_join(file_name)
				var npc_def = load(full_path)
				if npc_def:
					npc_defs.append(npc_def)
					
			file_name = npcs_dir.get_next()
			
		npcs_dir.list_dir_end()
	else:
		push_error("Failed to open directory: " + path)
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
