extends Node

@export var target_zoom: Vector2 = Vector2(2.0, 2.0)  # default zoom
@export var zoom_step: float = 0.1
# TODO will need to grab this from wherever we're keeping player/quest data
var min_zoom: float = Global.MIN_ZOOM
var max_zoom: float = Global.MAX_ZOOM

func _ready() -> void:
	SignalBus.zoom_updated.emit(target_zoom)
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_UP:
					target_zoom *= 1 + zoom_step
				MOUSE_BUTTON_WHEEL_DOWN:
					target_zoom *= 1 - zoom_step
		var clamped = clamp(target_zoom.x, min_zoom, max_zoom)
		target_zoom = Vector2(clamped, clamped)
		SignalBus.zoom_updated.emit(target_zoom)
