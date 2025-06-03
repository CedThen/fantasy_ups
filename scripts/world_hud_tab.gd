@tool
class_name WorldHudTab extends Control

signal tab_pressed(tab:WorldHudTab, opening:bool)

@export var active_img:Texture2D:
	set(v):
		active_img = v
		
@export var inactive_img:Texture2D:
	set(v):
		inactive_img = v
		set_button_image(v)

var is_active:bool = false

@onready var tab_button: TextureButton = %TabButton
@onready var animation_player: HudAnimationPlayer = %AnimationPlayer


func _ready() -> void:
	animation_player.animation_finished.connect(on_animation_finished)
	pass


func set_button_image(img:Texture2D):
	%TabButton.texture_normal = img


func on_animation_finished(anim_name:String) -> void:
	if anim_name == Global.ANIM_NAME_INTRO:
		set_button_image(active_img)
		is_active = true
	elif anim_name == Global.ANIM_NAME_OUTRO:
		set_button_image(inactive_img)
		is_active = false
	pass
	
	
func _on_tab_button_pressed() -> void:
	if animation_player.anim_state == Global.AnimState.OUT:
		animation_player.intro()
		tab_pressed.emit(self, true)
	elif animation_player.anim_state == Global.AnimState.IN:
		animation_player.outro()
		tab_pressed.emit(self, false)
