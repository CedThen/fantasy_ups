class_name MainHud extends CanvasLayer

@onready var quest_box_button: TextureButton = %QuestBoxButton
@onready var world_map_button: TextureButton = %WorldMapButton

var anim_state:Global.AnimState = Global.AnimState.OUT

func _ready() -> void:
	open()
	
	SignalBus.world_map_pressed.connect(on_world_map_pressed)
	pass

func _process(delta: float) -> void:
	if anim_state == Global.AnimState.ANIMATING:
		if is_everything_out():
			anim_state = Global.AnimState.OUT
			hide()
		elif is_everything_in():
			anim_state = Global.AnimState.IN
			
		
			
		

func is_everything_out() -> bool:
	if quest_box_button.is_out() and world_map_button.is_out():
		return true
		
	return false
	

func is_everything_in() -> bool:
	if quest_box_button.is_in() and world_map_button.is_in():
		return true
		
	return false
	

func open() -> void:
	show()
	anim_state = Global.AnimState.ANIMATING
	quest_box_button.intro()
	world_map_button.intro()


func close() -> void:
	anim_state = Global.AnimState.ANIMATING
	quest_box_button.outro()
	world_map_button.outro()


func on_world_map_pressed():
	close()
