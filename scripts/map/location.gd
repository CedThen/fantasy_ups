@tool
class_name Location extends Node2D

@onready var location_label: Label = %LocationLabel
@export var label: String

# may be dependant on key items
var is_reachable = true
var neighbors: Dictionary[Location, float] = {}

func _ready() -> void:
	location_label.text = label
	get_neighbors()
	

func get_neighbors():
	for child in get_children():
		if child is Route:
			neighbors[child.destination] = child.weight
	
	for neighbor in neighbors:
		print(neighbor.location_label, neighbors[neighbor])

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		location_label.text = label

func check_is_reachable():
	pass
