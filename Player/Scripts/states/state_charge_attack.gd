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
@onready var charge_hurt_box: HurtBox = %ChargeHurtBox
@onready var charge_spin_hurt_box: HurtBox = %ChargeSpinHurtBox
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $'../../Audio/AudioStreamPlayer2D'
@onready var spin_effect_sprite_2d: Sprite2D = $'../../Sprite2D/SpinEffectSprite2D'
@onready var spin_animation_player: AnimationPlayer = $'../../Sprite2D/SpinEffectSprite2D/AnimationPlayer'
@onready var gpuparticles_2d: GPUParticles2D = $'../../Sprite2D/ChargeHurtBox/GPUParticles2D'



## what happends when we initialize this state?
func init() -> void:
	gpuparticles_2d.emitting = false
	particles = gpuparticles_2d.process_material as ParticleProcessMaterial
	spin_effect_sprite_2d.visible = false


# what happens when the player enters this State?
func Enter() -> void:
	timer = charge_duration
	is_attacking = false
	walking = false
	charge_hurt_box.monitoring = true
	gpuparticles_2d.emitting = true
	gpuparticles_2d.amount = 4
	gpuparticles_2d.explosiveness = 0
	particles.initial_velocity_min = 10
	particles.initial_velocity_max = 30


# what happens when the player exits this State?
func Exit() -> void:
	charge_hurt_box.monitoring = false
	charge_spin_hurt_box.monitoring = false
	spin_effect_sprite_2d.visible = false
	gpuparticles_2d.emitting = false


# what happens during the _process update in this State?
func Process( _delta : float) -> State:
	if timer > 0:
		timer -= _delta
		if timer <= 0:
			timer = 0
			charge_complete()

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
	is_attacking = true
	# play animation
	player.animation_player.play("charge_attack")
	player.animation_player.seek(get_spin_frame())
	play_audio(sfx_spin)
	spin_effect_sprite_2d.visible = true
	spin_animation_player.play("spin")

	var _duration : float = player.animation_player.current_animation_length
	player.make_invulnerable(_duration)
	charge_spin_hurt_box.monitoring = true

	# wait for spin attack to complete
	await get_tree().create_timer(_duration * 0.875).timeout

	state_machine.ChangeState(idle)


func get_spin_frame() -> float:
	var interval : float = 0.05
	match player.cardinal_direction:
		Vector2.DOWN:
			return interval * 0
		Vector2.UP:
			return interval * 4
		_:
			return interval * 6


func charge_complete() -> void:
	play_audio(sfx_charged)

	gpuparticles_2d.amount = 50
	gpuparticles_2d.explosiveness = 1
	particles.initial_velocity_min = 50
	particles.initial_velocity_max = 100

	await get_tree().create_timer(0.5).timeout
	
	gpuparticles_2d.amount = 10
	gpuparticles_2d.explosiveness = 0
	particles.initial_velocity_min = 10
	particles.initial_velocity_max = 30


func play_audio(_audio : AudioStream) -> void:
	audio_stream_player_2d.stream = _audio
	audio_stream_player_2d.play()