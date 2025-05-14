extends Node

signal dialogic_quest_accepted()
signal dialogic_quest_rejected()


signal quest_completed(quest:QuestInstance)
signal quest_accepted(quest:QuestInstance)

signal location_hovered(location: Location)
signal location_exited(location: Location)
