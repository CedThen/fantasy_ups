@tool
class_name Place extends Node2D

@onready var place_sprite: Sprite2D = $PlaceSprite
@onready var place_label: Label = %PlaceLabel

@export var place_def: PlaceDef

func _ready() -> void:
	render_place()


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		render_place()

func render_place():
	place_sprite.texture = place_def.default_texture
	place_label.text = place_def.id
