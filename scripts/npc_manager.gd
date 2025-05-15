class_name NPCManager extends Node

var npc_defs:Array[NPCDef]

var npc_instances:Array[NPCInstance]	# SERIALIZED: not sure if this should get saved or diff data


func _init():
	load_all_npc_defs()
	

func _ready():
	Global.npc_manager = self
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
		move_npc(npc_instance, npc_def.initial_location_def)
		npc_instances.append(npc_instance)
		

func move_npc(npc_instance:NPCInstance, loc_def:LocationDef):
	var map:WorldMap = Global.get_map()
	if not map:
		return
	if not loc_def:
		printerr("No location def specified")
		return
		
	var location = map.get_location_by_def(loc_def)
	if not location:
		printerr("Failed to move NPC to location:" + loc_def.name + " No location found in map")
		return
		
	npc_instance.location = location
	print("Placed " + npc_instance.def.name + " at " + loc_def.name)


func get_npc_instance_by_def(npc_def:NPCDef) -> NPCInstance:
	for npc_instance in npc_instances:
		if npc_instance.def == npc_def:
			return npc_instance

	return

func get_npcs_at_location(loc:Location) -> Array[NPCInstance]:
	var ret:Array[NPCInstance]
	for npc_instance:NPCInstance in npc_instances:
		if npc_instance.location == loc:
			ret.append(npc_instance)
			
	return ret
	
func is_npc_instance_at_location(npc_instance:NPCInstance, loc:Location) -> bool:
	var npc_instances:Array[NPCInstance] = get_npcs_at_location(loc)
	if npc_instances.has(npc_instance):
		return true
		
	return false
