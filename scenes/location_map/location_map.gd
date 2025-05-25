@tool
class_name LocationMap extends Node2D

@onready var places: Node2D = %Places
@onready var title_label: Label = %TitleLabel
@onready var place_map_texture: Sprite2D = %PlaceMapTexture

@export var place_map_def: PlaceMapDef

func _ready() -> void:
	render_place_map()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		render_place_map()


func render_place_map():
	title_label.text = place_map_def.parent_location.name
	place_map_texture.texture = place_map_def.place_map_texture
