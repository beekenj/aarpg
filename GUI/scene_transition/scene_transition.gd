extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer


func fade(_anim : String) -> bool:
	animation_player.play(_anim)
	await animation_player.animation_finished
	return true
