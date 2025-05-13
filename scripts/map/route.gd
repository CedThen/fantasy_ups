@tool
class_name Route extends Line2D

@onready var color_rect: ColorRect = $ColorRect
@onready var weight_label: Label = $ColorRect/WeightLabel

@export var origin: Location
@export var destination: Location
@export var line_color: Color = Color(1, 0, 0)
@export var weight: float = 1.0
@export var isTraversable = true
@export var isVisible = true

# need to query some source to check if prereqs are met
#var prereqs

func _ready() -> void:
	render_route()

func _process(delta: float) -> void:
	# to render in editor mode
	if Engine.is_editor_hint():
		render_route() 

func render_route():
	visible = isVisible
	if origin and destination:
		var start_point = to_local(origin.global_position)
		var end_point = to_local(destination.global_position)
		points = [start_point, end_point]
		color_rect.position = (start_point + end_point) * 0.5
		weight_label.text = str(weight)
		default_color = line_color

# returns vertices and weight
func get_route_info():
	return {origin: origin, destination: destination, weight: weight}
	
