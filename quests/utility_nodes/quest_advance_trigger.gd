@tool
@icon("res://quests/utility_nodes/icons/quest_advance.png")
extends QuestNode
class_name QuestAdvanceTrigger




func _ready() -> void:
    if Engine.is_editor_hint():
        return
    # ...



func advance_quest() -> void:
    if linked_quest == null:
        return
    
    var _title : String = linked_quest.title
    var _step : String = get_step()

    if _step == "N/A":
        _step = ""


    print("advance_quest: ", _title)
    QuestManager.update_quest(_title, _step, quest_complete)



