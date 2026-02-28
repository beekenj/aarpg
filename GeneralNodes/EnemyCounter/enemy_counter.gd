class_name EnemyCounter extends Node2D


signal enemies_defeated


func _ready() -> void:
	child_exiting_tree.connect(_on_enemy_destroyed)
	pass


func _on_enemy_destroyed(e: Node2D) -> void:
	if e is Enemy and enemy_count() <= 1:
		enemies_defeated.emit()


func enemy_count() -> int:
	var _count : int = 0
	for c in get_children():
		_count += 1 if c is Enemy else 0
	return _count
