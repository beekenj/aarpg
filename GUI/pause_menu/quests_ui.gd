extends Control
class_name QuestsUI

const QUEST_ITEM : PackedScene = preload("res://GUI/pause_menu/quests/quest_item.tscn")



@onready var quest_item_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer



func _ready() -> void:
	visibility_changed.connect(_on_visible_changed)


func _on_visible_changed() -> void:
	for i in quest_item_container.get_children():
		i.queue_free()

	if visible == true:
		# update the list
		for q in QuestManager.current_quests:
			var quest_data : Quest = QuestManager.find_quest_by_title(q.title)
			if quest_data == null:
				continue
			var new_q_item : QuestItem = QUEST_ITEM.instantiate()
			quest_item_container.add_child(new_q_item)
			new_q_item.initialize(quest_data, q)
			# connect to focus entered
			
