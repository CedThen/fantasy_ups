class_name Item extends Node

var def:ItemDef
var count:int = 0


func _init(item_def:ItemDef):
	def = item_def
	count = 0
