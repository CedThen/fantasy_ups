class_name Player extends Node

@export var location:int	# Type TBD
@export var point:int		# Type TBD

var inventory:Array[String]		# Type TBD


func has_item(item:String) -> bool:
	if inventory.has(item):
		return true
		
	return false
