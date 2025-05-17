class_name RouteManager extends Node

var world_map: WorldMap

func _ready() -> void:
	world_map = Global.get_map()
