@tool
class_name Location extends Node2D

@onready var location_label: Label = %LocationLabel
@onready var halo_light: PointLight2D = $HighlightArea/HaloLight

@export var location_name: String = ""

var isMouseHovering := false

# may be dependant on key items
#var is_reachable = true
#var neighbors: Dictionary[Location, float] = {}

func _ready() -> void:
	location_label.text = location_name	

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		location_label.text = location_name

func check_is_reachable():
	pass


func _on_highlight_area_mouse_entered() -> void:
	print('mouse entered area')
	isMouseHovering = true
	halo_light.visible = true


func _on_highlight_area_mouse_exited() -> void:
	isMouseHovering = false
	halo_light.visible = false


#func get_neighbors():
	#for child in get_children():
		#if child is Route:
			#neighbors[child.destination] = child.weight
	#
	#print(label)
	#for neighbor in neighbors:
		#print(neighbor.label," ", neighbors[neighbor])
