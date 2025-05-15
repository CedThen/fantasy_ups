extends TextureButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	pass
	
	
func intro() -> void:
	animation_player.intro()
	

func outro() -> void:
	animation_player.outro()


func is_in() -> bool:
	return animation_player.anim_state == Global.AnimState.IN


func is_out() -> bool:
	return animation_player.anim_state == Global.AnimState.OUT


func _on_pressed() -> void:
	SignalBus.location_map_pressed.emit()
