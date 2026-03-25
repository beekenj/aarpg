@tool
@icon("res://GUI/dialog_system/icons/star_bubble.svg")
extends CanvasLayer
class_name DialogSystemNode


var is_active := false


@onready var dialog_ui: Control = $DialogUI



func _ready() -> void:
    if Engine.is_editor_hint():
        if get_viewport() is Window:
            get_parent().remove_child(self)
            return
        return
    hide_dialog()


func _unhandled_input(event: InputEvent) -> void:
    # if not is_active:
    #     return
    if event.is_action_pressed("test"):
        if not is_active:
            show_dialog()
        else:
            hide_dialog()


func show_dialog() -> void:
    is_active = true
    dialog_ui.visible = true
    dialog_ui.process_mode = Node.PROCESS_MODE_ALWAYS
    get_tree().paused = true


func hide_dialog() -> void:
    is_active = false
    dialog_ui.visible = false
    dialog_ui.process_mode = Node.PROCESS_MODE_DISABLED
    get_tree().paused = false