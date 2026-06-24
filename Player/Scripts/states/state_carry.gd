extends State
class_name State_Carry

@export var move_speed : float = 100.0
@export var throw_audio : AudioStream

var walking : bool = false
var throwable : Throwable

@onready var idle: State_Idle = $'../Idle'
@onready var stun: State_Stun = $'../Stun'


## what happends when we initialize this state?
func init() -> void:
	pass


# what happens when the player enters this State?
func Enter() -> void:
	player.update_animation("carry")
	walking = false


# what happens when the player exits this State?
func Exit() -> void:
	# throw object
	if throwable:
		# throw direction
		# were we stunned? if so drop item
		if state_machine.next_state == stun:
			# drop item
			pass
		# otherwise throw item
		else:
			# throw item
			pass
	pass


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		walking = false
		player.update_animation("carry")
	elif player.set_direction() or not walking:
		player.update_animation("carry_walk")
		walking = true
	
	player.velocity = player.direction * move_speed
	return null


# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null


# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("Attack") or _event.is_action_pressed("interact"):
		return idle
	return null