@tool
class_name Location extends Node2D

@onready var location_label: Label = %LocationLabel
@onready var halo_light: PointLight2D = $HighlightArea/HaloLight
@onready var highlight_area: Area2D = $HighlightArea
@onready var mouse_collision_shape: CollisionShape2D = $HighlightArea/MouseCollisionShape
@onready var map_icon: Sprite2D = %MapIcon

@export var location_def:LocationDef
var isMouseHovering := false
var base_scale := Vector2(1,1)
var zoom_level := Vector2(1,1)
var icon_scale_speed := 4.0
var font_scale_speed := 10.0
var size_data
var scaled_values = {
	"icon_scale": 1,
	"font_size": 1,
}
var LocationSmall = {
	"area_radius": 15,
	"text_font_min": 250,
	"text_font_max":400,
	"icon_scale_min": Vector2(0.03, 0.03),
	"icon_scale_max": Vector2(0.08,0.08)
}
var LocationMedium = {
	"area_radius": 30,
	"text_font_min": 300,
	"text_font_max":400,
	"icon_scale_min": Vector2(0.05, 0.05),
	"icon_scale_max": Vector2(0.13,0.13)
}
var LocationLarge = {
	"area_radius": 45,
	"text_font_min": 350,
	"text_font_max":400,
	"icon_scale_min": Vector2(0.08, 0.08),
	"icon_scale_max": Vector2(0.15,0.15)
}
# TODO use these to hide things at certain zoom scale levels
var zoom_scale_breakpoints = [0.3, 0.6]

func render_on_map():
	size_data = get_size(location_def.size)
	if not size_data:
		return
	scale_values()
	location_label.text = location_def.name
	if location_def.default_texture:
		map_icon.texture = location_def.default_texture
		map_icon.scale = scaled_values["icon_scale"]
	
	
	if mouse_collision_shape:
		var new_radius = float(size_data["area_radius"])
		if mouse_collision_shape.shape is CircleShape2D:
			var shape := CircleShape2D.new()
			shape.radius = new_radius
			mouse_collision_shape.shape = shape

func get_size(location_size: int):
	match location_size:
		LocationDef.Size.SMALL:
			return LocationSmall
		LocationDef.Size.MEDIUM:
			return LocationMedium
		LocationDef.Size.LARGE:
			return LocationLarge
		_:
			return {}


func _ready() -> void:
	render_on_map()
	SignalBus.zoom_updated.connect(on_zoom_update)

func scale_values():
	var min_zoom: float = Global.MIN_ZOOM
	var max_zoom: float = Global.MAX_ZOOM
	var zoom_fraction = clamp((zoom_level.x - min_zoom) / (max_zoom - min_zoom), 0.0, 1.0)

	scaled_values["icon_scale"] = size_data["icon_scale_max"].lerp(size_data["icon_scale_min"], zoom_fraction)
	scaled_values["font_size"] = lerp(size_data["text_font_min"],size_data["text_font_max"], zoom_fraction)

func on_zoom_update(new_zoom: Vector2):
	zoom_level = new_zoom
	scale_values()

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		render_on_map()
	if not scaled_values:
		return
	map_icon.scale = map_icon.scale.lerp(scaled_values["icon_scale"], delta * icon_scale_speed)
	var curr_font_size = location_label.get_theme_font_size("font_size")
	var lerped_font_size = lerpf(curr_font_size, scaled_values["font_size"], delta * font_scale_speed)
	location_label.add_theme_font_size_override("font_size", lerped_font_size)

func highlight_location(is_hovering: bool):
	if is_hovering:
		map_icon.texture = location_def.hover_texture
	else:
		map_icon.texture = location_def.default_texture


func _on_highlight_area_mouse_entered() -> void:
	isMouseHovering = true
	highlight_location(true)
	SignalBus.location_hovered.emit(self)


func _on_highlight_area_mouse_exited() -> void:
	isMouseHovering = false
	highlight_location(false)
	SignalBus.location_exited.emit(self)


func _on_highlight_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if isMouseHovering and event is InputEventMouseButton and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		SignalBus.location_clicked.emit(self)
		print("Area clicked " + location_def.name)
