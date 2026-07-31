# QUEST MANAGER - GLOBAL SCRIPT
extends Node

signal quest_updated(q : Quest)

const QUEST_DATA_LOCATION : String = "res://quests/"

var quests : Array[Quest]
var current_quests : Array = [
    {title = "Recover Lost Magical Flute", is_complete = false, completed_steps = ['']}
]


func _ready() -> void:
    # gather all quests
    gather_quest_data()
    pass


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("test"):
        print(find_quest(load("res://quests/recover_lost_flute.tres") as Quest))


# gather all quest resources and add to quest array
func gather_quest_data() -> void:
    var quest_files : PackedStringArray = DirAccess.get_files_at(QUEST_DATA_LOCATION)
    quests.clear()
    for q in quest_files:
        quests.append(load(QUEST_DATA_LOCATION + "/" + q) as Quest)
    print("quests count: ", quests.size())


# update the status of a quest
func update_quest() -> void:
    pass


# give XP and item rewards to player
func disperse_quest_rewards() -> void:
    pass

# provide a quest and return the current associated with it
func find_quest(_quest : Quest) -> Dictionary:
    for q in current_quests:
        if q.title == _quest.title:
            return q
    return {title = "not found", is_complete = false, completed_steps = ['']}


# take title and find associated quest resource
func find_quest_by_title(_title : String) -> Quest:
    return null


# find quest by title name, and return index in Quests array
func get_quest_index_by_title(_title : String) -> int:
    return -1


func sort_quests() -> void:
    pass



