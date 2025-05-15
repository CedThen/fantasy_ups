extends AnimationPlayer

var anim_state:Global.AnimState = Global.AnimState.OUT

func _ready():
	self.animation_finished.connect(on_finished)
	self.speed_scale = 5


func intro() -> void:
	if anim_state == Global.AnimState.IN:
		return
		
	play(Global.ANIM_NAME_INTRO)
	anim_state = Global.AnimState.ANIMATING
	
	
func outro() -> void:
	if anim_state == Global.AnimState.OUT:
		return
		
	play(Global.ANIM_NAME_OUTRO)
	anim_state = Global.AnimState.ANIMATING


func on_finished(anim_name:String):
	if anim_name == Global.ANIM_NAME_INTRO:
		anim_state = Global.AnimState.IN
	elif anim_name == Global.ANIM_NAME_OUTRO:
		anim_state = Global.AnimState.OUT
