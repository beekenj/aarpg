@tool
@icon("res://GUI/dialog_system/icons/chat_bubble.svg")
extends Node
class_name DialogItem


@export var npc_info : NPCResource

var editor_selection : EditorSelection
var example_dialog : DialogSystemNode


func _ready() -> void:
    if Engine.is_editor_hint():
        editor_selection = EditorInterface.get_selection()
        return
    check_npc_data()


func check_npc_data() -> void:
    if npc_info == null:
        var p = self
        var _checking := true
        while  _checking:
            p = p.get_parent()
            if p:
                if p is NPC and p.npc_resource:
                    npc_info = p.npc_resource
            else:
                _checking = false
