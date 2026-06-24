extends Area2D
class_name Throwable

@export var gravity_strength : float = 980.0
@export var throw_speed : float = 400.0
@export var throw_hight_strength : float = 100.0
@export var throw_starting_height : float = 49

var picked_up : bool = false
var throwable : Node2D
var throw_direction : Vector2
var object_sprite : Sprite2D
var vertical_velocity : float = 0
var ground_height : float = 0
var animation_player : AnimationPlayer

@onready var hurt_box: HurtBox = $HurtBox



func _ready() -> void:
    area_entered.connect(_on_area_enter)
    area_exited.connect(_on_area_exit)
    throwable = get_parent()
    setup_hurt_box()

    object_sprite = throwable.find_child("Sprite2D")
    ground_height = object_sprite.position.y
    animation_player = throwable.find_child("AnimationPlayer")


func player_interact() -> void:
    # pick up one pot only ...
    if not picked_up:
        # pick up throwable object
        disable_collisions(throwable)
        if throwable.get_parent():
            throwable.get_parent().remove_child(throwable)
        PlayerManager.player.held_item.add_child(throwable)
        throwable.position = Vector2.ZERO
        PlayerManager.player.pickup_item(self)
        area_entered.disconnect(_on_area_enter)
        area_exited.disconnect(_on_area_exit)


func throw() -> void:
    throwable.get_parent().remove_child(throwable)
    PlayerManager.player.get_parent().call_deferred("add_child", throwable)
    throwable.position = PlayerManager.player.position
    object_sprite.position.y = -throw_starting_height
    vertical_velocity = -throw_hight_strength
    # Enable physics
    # Enable hurt box


func disable_collisions(_node : Node) -> void:
    for c in _node.get_children():
        if c == self:
            continue
        if c is CollisionShape2D:
            c.disabled = true
        else:
            disable_collisions(c)


func _on_area_enter(_a : Area2D) -> void:
    PlayerManager.interact_pressed.connect(player_interact)


func _on_area_exit(_a : Area2D) -> void:
    PlayerManager.interact_pressed.disconnect(player_interact)


func setup_hurt_box() -> void:
    hurt_box.monitoring = false
    for c in get_children():
        if c is CollisionShape2D:
            var _col : CollisionShape2D = c.duplicate()
            hurt_box.add_child(_col)
            _col.debug_color = Color(1,0,0,0.5)