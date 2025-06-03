extends Control

@onready var backpack_tab: WorldHudTab = %BackpackTab
@onready var pouch_tab: WorldHudTab = %PouchTab
@onready var courier_tab: WorldHudTab = %CourierTab

@onready var inventory_button: TextureButton = %InventoryButton
@onready var inventory_button_animation_player: HudAnimationPlayer = %InventoryButtonAnimationPlayer
@onready var inventory_type_label: Label = %InventoryTypeLabel

@export var inventory_button_active_img:Texture2D
@export var inventory_button_inactive_img:Texture2D

var last_tab:WorldHudTab = null

func _ready() -> void:
	backpack_tab.tab_pressed.connect(on_tab_pressed)
	pouch_tab.tab_pressed.connect(on_tab_pressed)
	courier_tab.tab_pressed.connect(on_tab_pressed)
	
	inventory_button_animation_player.animation_finished.connect(on_inventory_animation_finished)
	last_tab = backpack_tab
	

	


func open() -> void:
	pass
	

func close() -> void:
	pass


# Tabs
func close_other_tabs(current_tab:WorldHudTab = null):
	if current_tab != backpack_tab:
		backpack_tab.animation_player.outro()
	if current_tab != pouch_tab:
		pouch_tab.animation_player.outro()
	if current_tab != courier_tab:
		courier_tab.animation_player.outro()


func populate_inventory(tab:WorldHudTab):
	var player_inventory:InventoryData = Global.player.inventory
	
	if tab == backpack_tab:
		inventory_type_label.text = "Backpack"
	elif tab == pouch_tab:
		inventory_type_label.text = "Pouch"
	elif tab == courier_tab:
		inventory_type_label.text = "Courier"


func on_tab_pressed(tab:WorldHudTab, opening:bool):
	if opening:
		close_other_tabs(tab)
		last_tab = tab
		populate_inventory(tab)
	else:
		close_other_tabs()
		inventory_button_animation_player.outro()
		last_tab = backpack_tab


# Main Button
func on_inventory_animation_finished(anim_name:String):
	if anim_name == Global.ANIM_NAME_INTRO:
		inventory_button.texture_normal = inventory_button_active_img
		last_tab.animation_player.intro()
		populate_inventory(last_tab)
	elif anim_name == Global.ANIM_NAME_OUTRO:
		inventory_button.texture_normal = inventory_button_inactive_img


func _on_inventory_button_pressed() -> void:
	if inventory_button_animation_player.anim_state == Global.AnimState.OUT:
		inventory_button_animation_player.intro()
	elif inventory_button_animation_player.anim_state == Global.AnimState.IN:
		inventory_button_animation_player.outro()
		close_other_tabs()
