@tool
@icon("res://quests/utility_nodes/icons/quest_switch.png")
extends QuestNode
class_name QuestActivatedSwitch

enum CheckType {HAS_QUEST, QUEST_STEP_COMPLETE, ON_CURRENT_QUEST_STEP, QUEST_COMPLETE}

signal is_activated_changed(v: bool)

@export var check_type : CheckType = CheckType.HAS_QUEST
@export var remove_when_activated : bool = false
@export var react_to_global_signal : bool = false

var is_activated : bool = false

