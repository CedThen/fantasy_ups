@tool
class_name Location extends Node2D

enum LocationSize {small, medium, large}

@onready var location_label: Label = %LocationLabel
@onready var halo_light: PointLight2D = $HighlightArea/HaloLight
@onready var highlight_area: Area2D = $HighlightArea
@onready var mouse_collision_shape: CollisionShape2D = $HighlightArea/MouseCollisionShape

@export var location_def:LocationDef = null

var isMouseHovering := false
var LocationSizeDict: Dictionary[LocationDef.Size, int] = {
	LocationDef.Size.SMALL: 15,
	LocationDef.Size.MEDIUM: 25,
	LocationDef.Size.LARGE: 45
}

# may be dependant on key items 
#var is_reachable = false
# var prereqs = [] # check if pc has required key items 
func render_on_map():
	location_label.text = location_def.name
	
	if mouse_collision_shape:
		var collision_shape = mouse_collision_shape.shape
		var new_radius = float(LocationSizeDict[location_def.size])
		if mouse_collision_shape.shape is CircleShape2D:
			# Make a copy to ensure editor updates properly
			var shape := CircleShape2D.new()
			shape.radius = new_radius
			mouse_collision_shape.shape = shape
		halo_light.texture_scale = new_radius / 5

func _ready() -> void:
	render_on_map()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		render_on_map()

func highlight_location(is_visible: bool):
	halo_light.visible = is_visible

func select_location():
	
	pass

func _on_highlight_area_mouse_entered() -> void:
	isMouseHovering = true
	highlight_location(true)
	SignalBus.location_hovered.emit(self)


func _on_highlight_area_mouse_exited() -> void:
	isMouseHovering = false
	highlight_location(false)
	SignalBus.location_exited.emit(self)


func _on_highlight_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if isMouseHovering and event is InputEventMouseButton and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		SignalBus.location_clicked.emit(self)
		print("Area clicked " + location_def.name)
	

func check_is_reachable():
	pass
