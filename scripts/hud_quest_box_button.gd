extends TextureButton

@onready var animation_player: AnimationPlayer = %AnimationPlayer

var anim_state:Global.AnimState = Global.AnimState.OUT

func _ready() -> void:
	pass
	
	
func intro() -> void:
	animation_player.intro()
	

func outro() -> void:
	animation_player.outro()
	

func _on_pressed() -> void:
	SignalBus.quest_box_pressed.emit()
	
