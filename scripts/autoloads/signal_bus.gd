extends Node

# Dialogic signals
signal dialogic_quest_accepted()
signal dialogic_quest_rejected()
signal dialogic_quest_completed()

# Main hud signals
signal calendar_pressed()
signal quest_box_pressed()
signal journal_pressed()
signal quest_log_pressed()
signal location_map_pressed()
signal world_map_pressed()
signal inventory_pressed()

signal main_inventory_opened()
signal inventory_updated()


signal quest_completed(quest: QuestInstance)
signal quest_accepted(quest: QuestInstance)

signal location_hovered(location: Location)
signal location_exited(location: Location)
signal location_clicked(location: Location)

signal player_location_updated()

signal zoom_updated(new_zoom: Vector2)
