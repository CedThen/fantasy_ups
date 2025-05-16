class_name PlaceDef extends Resource

enum PlaceSize {small, medium, large}

@export var id: String
@export var size: PlaceSize

@export var default_texture: Texture2D
@export var hover_texture: Texture2D
@export var click_texture: Texture2D

# @export var requirements
# @export var 
