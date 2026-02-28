class_name State extends Node

## a reference to the  player that this State belongs to
static var player : Player
static var state_machine: PlayerStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

## what happends when we initialize this state?
func init() -> void:
	pass


# what happens when the player enters this State?
func Enter() -> void:
	pass


# what happens when the player exits this State?
func Exit() -> void:
	pass


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	return null


# What happens during the _physics_process update in this State?
func Physics( _delta : float) -> State:
	return null


# What happens with inpu events in this State?
func HandleInput( _event : InputEvent) -> State:
	return null
