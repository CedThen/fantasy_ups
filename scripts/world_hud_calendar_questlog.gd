extends Control


var last_tab: WorldHudTab

@onready var calendar_tab: WorldHudTab = %CalendarTab
@onready var questlog_tab: WorldHudTab = %QuestlogTab

@onready var calendar_animation_player: HudAnimationPlayer = %CalendarAnimationPlayer
@onready var calendar_label: Label = %CalendarLabel
@onready var questlog_animation_player: HudAnimationPlayer = %QuestlogAnimationPlayer
@onready var questlog_label: Label = %QuestlogLabel

func _ready() -> void:
	calendar_tab.tab_pressed.connect(on_tab_pressed)
	questlog_tab.tab_pressed.connect(on_tab_pressed)
	pass


# Tabs
func close_other_tabs(current_tab:WorldHudTab = null):
	if current_tab != calendar_tab:
		calendar_tab.animation_player.outro()
		calendar_animation_player.outro()
	if current_tab != questlog_tab:
		questlog_tab.animation_player.outro()
		questlog_animation_player.outro()


func populate_main_content(tab:WorldHudTab):
	if tab == calendar_tab:
		calendar_animation_player.intro()
		calendar_label.text = "CALENDAR"
	elif tab == questlog_tab:
		questlog_animation_player.intro()
		calendar_label.text = "QUESTS"


func on_tab_pressed(tab:WorldHudTab, opening:bool):
	if opening:
		close_other_tabs(tab)
		last_tab = tab
		populate_main_content(tab)
	else:
		close_other_tabs()
		last_tab = null
