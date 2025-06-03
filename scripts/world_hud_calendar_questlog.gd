extends Control


var last_tab: WorldHudTab

@onready var calendar_tab: WorldHudTab = %CalendarTab
@onready var questlog_tab: WorldHudTab = %QuestlogTab

@onready var animation_player: HudAnimationPlayer = %AnimationPlayer
@onready var label: Label = %Label

func _ready() -> void:
	calendar_tab.tab_pressed.connect(on_tab_pressed)
	questlog_tab.tab_pressed.connect(on_tab_pressed)
	pass


# Tabs
func close_other_tabs(current_tab:WorldHudTab = null):
	if current_tab != calendar_tab:
		calendar_tab.animation_player.outro()
	if current_tab != questlog_tab:
		questlog_tab.animation_player.outro()


func populate_main_content(tab:WorldHudTab):
	if tab == calendar_tab:
		label.text = "CALENDAR"
	elif tab == questlog_tab:
		label.text = "QUESTS"


func on_tab_pressed(tab:WorldHudTab, opening:bool):
	if opening:
		close_other_tabs(tab)
		if last_tab == null:
			animation_player.intro()
		last_tab = tab
		populate_main_content(tab)
	else:
		close_other_tabs()
		animation_player.outro()
		last_tab = null
