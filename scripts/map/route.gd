@tool
class_name Route extends Line2D

@onready var color_rect: ColorRect = $ColorRect
@onready var weight_label: Label = $ColorRect/WeightLabel

@export var origin: Location
@export var destination: Location
@export var line_color: Color = Color(1, 0, 0)
@export var weight: float = 1.0
@export var isTraversable = true

# need to query some source to check if prereqs are met
var prereqs

func _ready() -> void:
	render_route()

func _process(delta: float) -> void:
	# to render in editor mode
	if Engine.is_editor_hint():
		render_route() 

func render_route():
	if destination:
		points[0] = origin.global_position - global_position
		var end_point = destination.global_position - origin.global_position
		points[1] = end_point
		color_rect.position = end_point * 0.5
		weight_label.text = str(weight)
		default_color = line_color

# returns vertices and weight
func get_route_info():
	var origin = get_parent()
	pass
	
