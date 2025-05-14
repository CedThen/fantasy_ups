extends Node

signal dialogic_quest_accepted()
signal dialogic_quest_rejected()
signal dialogic_quest_completed()


signal quest_completed(quest: QuestInstance)
signal quest_accepted(quest: QuestInstance)

signal location_hovered(location: Location)
signal location_exited(location: Location)

signal location_clicked(location: Location)

signal player_location_updated()
