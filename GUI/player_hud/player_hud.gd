extends CanvasLayer


var hearts : Array[HeartGUI] = []
@onready var hud_control: Control = $HUDControl


func _ready() -> void:
	for child in $HUDControl/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.visible = false
	PauseMenu.shown.connect(_game_pause)
	PauseMenu.hidden.connect(_game_unpause)
	pass


func update_hp( _hp : int, _max_hp : int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, _hp)
	pass


func update_heart(_index : int, _hp : int) -> void:
	var _value : int = clampi(_hp - _index * 2, 0, 2)
	hearts[_index].value = _value
	pass


func update_max_hp(_max_hp : int) -> void:
	var _heart_count : int = roundi(_max_hp * 0.5)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass


func _game_pause() -> void:
	hud_control.mouse_filter = Control.MOUSE_FILTER_IGNORE
	

func _game_unpause() -> void:
	hud_control.mouse_filter = Control.MOUSE_FILTER_PASS
