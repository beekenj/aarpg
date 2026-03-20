class_name State_Walk extends State

@export var move_speed : float = 100.0

# ** my addition **
@export var run_mult : float = 2.5

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"


# what happens when the player enters this State?
func Enter() -> void:
	player.update_animation("walk")
	pass


# what happens when the player exits this State?
func Exit() -> void:
	pass


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.update_animation("walk")
	
	return null


# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null


# What happens with input events in this State?
func HandleInput( _event : InputEvent) -> State:
	if _event.is_action_pressed("Attack"):
		return attack
	if _event.is_action_pressed("interact"):
		PlayerManager.interact_pressed.emit()
	
#	** my additions **
	if _event.is_action_pressed("Run"):
		move_speed *= run_mult
	if _event.is_action_released("Run"):
		move_speed /= run_mult
#	******************
		
		
	return null
