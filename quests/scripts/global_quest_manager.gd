# QUEST MANAGER - GLOBAL SCRIPT
extends Node

signal quest_updated(q)

const QUEST_DATA_LOCATION : String = "res://quests/"

var quests : Array[Quest]
var current_quests : Array = [
    {title = "Recover Lost Magical Flute", is_complete = false, completed_steps = ['']},
    {title = "Long Quest", is_complete = false, completed_steps = ['']},
]


func _ready() -> void:
    # gather all quests
    gather_quest_data()
    pass


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("test"):
        # print(find_quest(load("res://quests/recover_lost_flute.tres") as Quest))
        # print(find_quest_by_title("short quest"))
        # print(get_quest_index_by_title("Recover Lost Magical Flute"))
        # print(get_quest_index_by_title("short quest"))
        update_quest("short quest")
        update_quest("Recover Lost Magical Flute", "Find the Magical Flute")
        update_quest("long quest", "", true)


# gather all quest resources and add to quest array
func gather_quest_data() -> void:
    var quest_files : PackedStringArray = DirAccess.get_files_at(QUEST_DATA_LOCATION)
    quests.clear()
    for q in quest_files:
        quests.append(load(QUEST_DATA_LOCATION + "/" + q) as Quest)
    print("quests count: ", quests.size())


# update the status of a quest
func update_quest(_title : String, _completed_step : String = '', _is_complete : bool = false) -> void:
    var quest_index : int = get_quest_index_by_title(_title)
    if quest_index == -1:
        # quest was not found - add it to the current quests array
        var new_quest : Dictionary = {
                title = _title, 
                is_complete = _completed_step, 
                completed_steps = []
        }
        if _completed_step != '':
            new_quest.completed_steps.append(_completed_step)
        current_quests.append(new_quest)
        quest_updated.emit(new_quest)

        # display a notification that quest was added
    else:
        # quest was found, update it
        var q = current_quests[quest_index]
        if _completed_step != '' and q.completed_steps.has(_completed_step) == false:
            q.completed_steps.append(_completed_step)
        q.is_complete = _is_complete
        quest_updated.emit(q)

        # dispaly a notification that quest was updated OR completed





# give XP and item rewards to player
func disperse_quest_rewards() -> void:
    pass

# provide a quest and return the current quest associated with it
func find_quest(_quest : Quest) -> Dictionary:
    for q in current_quests:
        if q.title == _quest.title:
            return q
    return {title = "not found", is_complete = false, completed_steps = ['']}


# take title and find associated quest resource
func find_quest_by_title(_title : String) -> Quest:
    for q in quests:
        if q.title.to_lower() == _title.to_lower():
            return q
    return null


# find quest by title name, and return index in Current Quests array
func get_quest_index_by_title(_title : String) -> int:
    for i in current_quests.size():
        if current_quests[i].title.to_lower() == _title.to_lower():
            return i
    # return a -1 if we didn't find a quest with a matching title in our array
    return -1


func sort_quests() -> void:
    pass



