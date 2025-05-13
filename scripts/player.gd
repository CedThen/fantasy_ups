class_name Player extends Node

@export var current_location:int	# Type TBD
@export var current_place:int		# Type TBD

var inventory:Array[String]			# Type TBD


func has_item(item:String) -> bool:
	if inventory.has(item):
		return true
		
	return false
