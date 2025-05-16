class_name MainHud extends CanvasLayer

@onready var quest_box_button: TextureButton = %QuestBoxButton
@onready var world_map_button: TextureButton = %WorldMapButton
@onready var inventory_button: TextureButton = %InventoryButton
@onready var quest_log_button: TextureButton = %QuestLogButton
@onready var journal_button: TextureButton = %JournalButton
@onready var location_map_button: TextureButton = %LocationMapButton
@onready var calendar_button: TextureButton = %CalendarButton

var show_quest_box:bool = true
var show_location_map:bool = true

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
	if calendar_button.is_out() and \
		journal_button.is_out() and \
		quest_log_button.is_out() and \
		world_map_button.is_out() and \
		inventory_button.is_out() and \
		quest_box_button.is_out() and \
		location_map_button.is_out():
		return true
		
	return false
	

func is_everything_in() -> bool:
	var quest_box_in: bool = true
	if show_quest_box:
		quest_box_in = quest_box_button.is_in()
	
	var location_map_in: bool = true
	if show_location_map:
		location_map_in = location_map_button.is_in()
		
	if calendar_button.is_in() and \
		journal_button.is_in() and \
		quest_log_button.is_in() and \
		world_map_button.is_in() and \
		inventory_button.is_in() and \
		quest_box_in and location_map_in:
		return true
		
	return false
	

func open(quest_box:bool = true, location_map:bool = true) -> void:
	show()
	show_quest_box = quest_box
	show_location_map = location_map
	
	anim_state = Global.AnimState.ANIMATING
	if show_quest_box:
		quest_box_button.intro()
		
	if show_location_map:
		location_map_button.intro()
	
	calendar_button.intro()
	journal_button.intro()
	quest_log_button.intro()
	world_map_button.intro()
	inventory_button.intro()
	

func close() -> void:
	anim_state = Global.AnimState.ANIMATING
	calendar_button.outro()
	quest_box_button.outro()
	journal_button.outro()
	quest_log_button.outro()
	location_map_button.outro()
	world_map_button.outro()
	inventory_button.outro()
	

func on_world_map_pressed():
	close()
