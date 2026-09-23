extends PanelContainer
class_name Stats

@onready var label_level: Label = $VBoxContainer/Level/Label2
@onready var label_xp: Label = $VBoxContainer/XP/Label2
@onready var label_attack: Label = $VBoxContainer/Attack/Label2
@onready var label_defense: Label = $VBoxContainer/Defense/Label2



func _ready() -> void:
    PauseMenu.shown.connect(update_stats)



func update_stats() -> void:
    var _p : Player = PlayerManager.player
    label_level.text = str(_p.level)
    label_xp.text = str(_p.xp) + "/" + str(PlayerManager.level_requirements[_p.level])
    label_attack.text = str(_p.attack)
    label_defense.text = str(_p.defense)



