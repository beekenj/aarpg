extends Node2D


const START_LEVEL : String = "res://Levels/Area01/02.tscn"

@onready var button_new : Button = $CanvasLayer/Control/ButtonNew
@onready var button2_continue : Button = $CanvasLayer/Control/ButtonContinue





func _ready() -> void:
	get_tree().paused = true
	PlayerManager.player.visible = false

	setup_title_screen()


func setup_title_screen() -> void:
	button_new.pressed.connect(start_game)


func start_game() -> void:
	LevelManager.load_new_level(START_LEVEL, "", Vector2.ZERO)
