extends Control

@onready var animation_player: HudAnimationPlayer = %AnimationPlayer

var expanded:bool = false

func _ready() -> void:
	animation_player.animation_finished.connect(on_animation_finished)


func on_animation_finished(anim_name:String):
	if anim_name == Global.ANIM_NAME_INTRO:
		expanded = true
	elif anim_name == Global.ANIM_NAME_OUTRO:
		expanded = false


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if not expanded:
				animation_player.intro()
			else:
				animation_player.outro()
			pass
