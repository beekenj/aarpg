extends Control
class_name QuestsUI

const QUEST_ITEM : PackedScene = preload("res://GUI/pause_menu/quests/quest_item.tscn")



@onready var quest_item_container: VBoxContainer = $Control/TabContainer/Quests/ScrollContainer/MarginContainer/VBoxContainer



func _ready() -> void:
    pass
