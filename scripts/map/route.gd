@tool
class_name Route extends Node2D

@onready var weight_label: Label = %WeightLabel
@onready var info_panel: PanelContainer = %InfoPanel
@onready var route_texture: Sprite2D = %RouteTexture
@onready var mouse_detection_area_2d: Area2D = %MouseDetectionArea2D

@export var route_def: RouteDef

const OFFSET_DISTANCE := 30.0
# TODO may need to centralize the z index
const LOCKED_Z_INDEX = 0
const UNLOCKED_Z_INDEX = 1

var origin
var destination
var is_visible: set = set_is_visible
var highlight_material: ShaderMaterial = preload("res://assets/shaders/materials/route_highlight_material.tres")
# turns off area detection when route is hidden
func set_is_visible(value: bool) -> void:
	mouse_detection_area_2d.monitoring = value


func _ready() -> void:
	render_route()
	is_visible = true
	if route_def.collision_polygon:
		var collision_polygon = CollisionPolygon2D.new()
		collision_polygon.polygon = route_def.collision_polygon
		mouse_detection_area_2d.add_child(collision_polygon)
	

func _process(_delta: float) -> void:
	# to render in editor mode
	if Engine.is_editor_hint():
		render_route()

func render_route():
	if not route_def:
		return
	origin = route_def.origin
	destination = route_def.destination
	
	match route_def.route_type:
		route_def.RouteTypes.UNLOCKED:
			route_texture.texture = route_def.default_route
			route_texture.centered = false
			route_texture.global_position = Vector2.ZERO
			route_texture.z_index = 1
		route_def.RouteTypes.LOCKED:
			route_texture.texture = route_def.default_route
			route_texture.centered = false
			route_texture.global_position = Vector2.ZERO
			#route_texture.self_modulate = "#87878779"
			route_texture.z_index = 0
		route_def.RouteTypes.HIDDEN:
			pass
	#route_texture.material = 


func _on_area_2d_mouse_entered() -> void:
	#if route_def.highlighted_route:
		#route_texture.texture = route_def.highlighted_route
	route_texture.material = highlight_material
	

func _on_area_2d_mouse_exited() -> void:
	#route_texture.texture = route_def.default_route	
	route_texture.material = null
