extends Node2D
class_name DarkWizardBoss

const ENERGY_EXPLOSION_SCENE : PackedScene = preload("res://Levels/Dungeon01/dark_wizard/energy_explosion.tscn")

@export var max_hp : int = 10
var hp : int = 10

var audio_hurt : AudioStream = preload("res://Levels/Dungeon01/dark_wizard/audio/boss_hurt.wav")

var current_position : int = 0
var positions : Array[Vector2]

@onready var animation_player: AnimationPlayer = $BossNode/AnimationPlayer
@onready var animation_player_damaged: AnimationPlayer = $BossNode/AnimationPlayer_Damaged
@onready var audio: AudioStreamPlayer2D = $BossNode/AudioStreamPlayer2D
@onready var boss_node: Node2D = $BossNode
@onready var persistent_data_handler: PersistentDataHandler = $PersistentDataHandler
@onready var hurt_box: HurtBox = $BossNode/HurtBox
@onready var hit_box: HitBox = $BossNode/HitBox


func _ready() -> void:
    
    hp = max_hp

    hit_box.damaged.connect(damage_taken)

    for c in $PositionTargets.get_children():
        positions.append(c.global_position)
    print(positions)
    $PositionTargets.visible = false



func damage_taken(_hurt_box : HurtBox) -> void:
    if animation_player_damaged.current_animation == "damaged" or _hurt_box.damage == 0:
        return
    play_audio(audio_hurt)    
    hp = clampi(hp - _hurt_box.damage, 0, max_hp)
    # Update Boss Health Bar
    animation_player_damaged.play("damaged")
    animation_player_damaged.seek(0)
    animation_player_damaged.queue("default")

    if hp < 1:
        defeat()


func play_audio(_a : AudioStream) -> void:
    audio.stream = _a
    audio.play()


func defeat() -> void:
    animation_player.play("destroy")
    enable_hit_boxes(false)
    persistent_data_handler.set_value()
    await animation_player.animation_finished
    # reopen the room


func enable_hit_boxes(_v : bool = true) -> void:
    hit_box.set_deferred("monitorable", _v)
    hurt_box.set_deferred("monitoring", _v)


func explosion(_p : Vector2 = Vector2.ZERO) -> void:
    var e : Node2D = ENERGY_EXPLOSION_SCENE.instantiate()
    e.global_position = boss_node.global_position + _p
    get_parent().add_child.call_deferred(e)