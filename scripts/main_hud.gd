class_name MainHud extends CanvasLayer

@onready var quest_box_button: TextureButton = %QuestBoxButton

func _ready() -> void:
	open()
	pass


func open() -> void:
	quest_box_button.intro()


func close() -> void:
	quest_box_button.outro()
