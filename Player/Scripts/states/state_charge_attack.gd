extends State
class_name State_ChargeAttack

@export var charge_duration : float = 1.0
@export var move_speed : float = 80.0
@export var sfx_charged : AudioStream
@export var sfx_spin : AudioStream

var timer : float = 0.0
var walking : bool = false
var is_attacking : bool = false
var particles : ParticleProcessMaterial

@onready var idle: State = $'../Idle'

## what happends when we initialize this state?
func init() -> void:
	pass


# what happens when the player enters this State?
func Enter() -> void:
	timer = charge_duration
	is_attacking = false
	walking = false


# what happens when the player exits this State?
func Exit() -> void:
	pass


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	if timer > 0:
		timer -= _delta
		if timer <= 0:
			timer = 0
			# charge complete

	if is_attacking == false:
		if player.direction == Vector2.ZERO:
			walking = false
			player.update_animation("charge")
		elif player.set_direction() or walking == false:
			walking = true
			player.update_animation("charge_walk")

	player.velocity = player.direction * move_speed
	return null


# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null


# What happens with inpu events in this State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_released("Attack"):
		if timer > 0:
			return idle
		elif is_attacking == false:
			charge_attack()
	return null



func charge_attack() -> void:
	print("charge attack")
	# play animation
	# do more stuff
	# wait for spin attack to complete
	state_machine.ChangeState(idle)