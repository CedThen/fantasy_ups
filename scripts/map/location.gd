@tool
class_name Location extends Node2D

@onready var location_label: Label = %LocationLabel

@export var label: String

# may be dependant on key items
var is_reachable = true
var id: String

func _ready() -> void:
	location_label.text = label

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		location_label.text = label

func check_is_reachable():
	pass
