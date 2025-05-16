extends Camera2D

@onready var map_sprite: Sprite2D = %MapSprite

@export var target_zoom: Vector2 = Vector2(1, 1)  # default zoom
@export var drag_lerp_speed := .2
@export var zoom_speed := 3.0

var is_dragging := false
var drag_origin := Vector2()
var target_position := Vector2.ZERO
var map_size: Vector2


func _ready():
	target_position = global_position
	map_size = map_sprite.texture.get_size() * map_sprite.scale
	SignalBus.zoom_updated.connect(on_zoom_change)

func on_zoom_change(new_zoom: Vector2):
	target_zoom = new_zoom

func _process(delta: float) -> void:
	if not zoom.is_equal_approx(target_zoom):
		zoom = zoom.lerp(target_zoom, delta * zoom_speed)
	else:
		zoom = target_zoom
	
	var map_top_left = map_sprite.global_position
	var map_bottom_right = map_top_left + map_size
	# TODO clamp based on camera + zoom
	target_position = target_position.clamp(map_top_left, map_bottom_right)
	global_position = global_position.lerp(target_position, drag_lerp_speed * delta)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = true
			drag_origin = event.global_position
	elif event is InputEventMouseButton and not event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = false
	
	if is_dragging and event is InputEventMouseMotion:
		var delta = event.global_position - drag_origin
		target_position -= delta / zoom.x
		drag_origin = event.global_position
