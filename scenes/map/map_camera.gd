extends Camera2D

@export var target_zoom: Vector2 = Vector2(1, 1)  # default zoom
@export var drag_lerp_speed := .5
@export var zoom_speed := 5.0
var is_dragging := false
var drag_origin := Vector2()
var target_position := Vector2.ZERO

func _ready():
	zoom = target_zoom
	target_position = global_position
	SignalBus.zoom_updated.connect(on_zoom_change)

func on_zoom_change(new_zoom: Vector2):
	target_zoom = new_zoom

func _process(delta: float) -> void:
	if not zoom.is_equal_approx(target_zoom):
		zoom = zoom.lerp(target_zoom, delta * zoom_speed)
	else:
		zoom = target_zoom
	#global_position = lerp(global_position, target_position, drag_lerp_speed * delta)

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
		global_position -= delta * zoom.x
		drag_origin = event.global_position  # update drag_origin to current position
