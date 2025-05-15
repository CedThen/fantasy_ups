extends Camera2D

@export var target_zoom: Vector2 = Vector2(1, 1)  # default zoom
@export var zoom_speed: float = 5.0
@export var zoom_step: float = 0.1
@export var drag_lerp_speed := 10.0


#TODO will need to grab this from wherever we're keeping player/quest data
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0

var is_dragging := false
var drag_origin := Vector2()
var target_position := Vector2.ZERO

func _enter_tree() -> void:
	Input.use_accumulated_input = false
	print(Input.use_accumulated_input)

func _ready():
	zoom = target_zoom
	target_position = global_position


func _process(delta: float) -> void:
	if not zoom.is_equal_approx(target_zoom):
		zoom = zoom.lerp(target_zoom, delta * zoom_speed)
	else:
		zoom = target_zoom
	#global_position = lerp(global_position, target_position, drag_lerp_speed * delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					target_zoom *= 1.1
				MOUSE_BUTTON_WHEEL_DOWN:
					target_zoom *= 0.9
				MOUSE_BUTTON_LEFT:
					is_dragging = true
					drag_origin = event.global_position
		else:
			if event.button_index == MOUSE_BUTTON_LEFT:
				is_dragging = false
		var clamped = clamp(target_zoom.x, min_zoom, max_zoom)
		target_zoom = Vector2(clamped, clamped)
	
	elif event is InputEventMouseButton and not event.pressed \
	and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = false
	
	if is_dragging and event is InputEventMouseMotion:
		print("Mouse global position: ", event.global_position)
		var delta = event.global_position - drag_origin
		global_position -= delta * zoom.x
		drag_origin = event.global_position  # update drag_origin to current position
