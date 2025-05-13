extends Node

enum MapMode {Plotting, Selecting}

@export var mode: MapMode = MapMode.Selecting

# handles highlights, selecting nodes and routing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
