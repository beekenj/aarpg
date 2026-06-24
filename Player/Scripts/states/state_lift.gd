extends State
class_name State_Lift


@export var lift_audio: AudioStream

@onready var carry : State = $"../Carry"



# what happens when the player enters this State?
func Enter() -> void:
	player.update_animation("lift")
	player.animation_player.animation_finished.connect(state_complete)
	player.audio.stream = lift_audio
	player.audio.play()


# what happens when the player exits this State?
func Exit() -> void:
	pass


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	player.velocity = Vector2.ZERO
	return null


# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null


# What happens with inpu events in this State?
func HandleInput( _event : InputEvent) -> State:
	return null


func state_complete(_a : String) -> void:
	player.animation_player.animation_finished.disconnect(state_complete)
	state_machine.ChangeState(carry)
