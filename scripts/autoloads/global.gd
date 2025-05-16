extends Node

# While I don't really like this - this will work for now

var player:Player
var map:WorldMap
var npc_manager:NPCManager


# Hud Animation Stuff
enum AnimState{ ANIMATING, IN, OUT}
const ANIM_NAME_INTRO = "intro"
const ANIM_NAME_OUTRO = "outro"


func get_player() -> Player:
	return player
	
	
func get_map() -> WorldMap:
	return map
	
func get_npc_manager() -> NPCManager:
	return npc_manager

# Map Stuff
const MIN_ZOOM = 0.85
const MAX_ZOOM = 3.0
