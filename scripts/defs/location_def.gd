class_name LocationDef extends Resource

enum Size {SMALL, MEDIUM, LARGE}

@export var name:String

@export var size:Size = Size.SMALL

@export var has_quest_box:bool = false

@export var default_texture: Texture2D
@export var hover_texture: Texture2D
@export var click_texture: Texture2D
