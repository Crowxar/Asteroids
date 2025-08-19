#1. @tool, @icon, @static_unload

#2. class_name

#3. extends
extends Area2D

#4. ## doc comment

#5. signals
signal Lost_Health

#6. enums
enum Ship_State {
	IDLE,
	MOVING,
	HIT,
	INVULN,
	DEAD,
}

#7. constants
const SHOOT_DURATION: float = 0.249

#8. @export variables
@export var shoot_point: Marker2D
@export var sprite_animation: AnimatedSprite2D
@export var collision: CollisionShape2D
@export var start_position: Marker2D
@export var wrap_margin: float = 0
@export var shield_sprite: Sprite2D
@export var animation_player: AnimationPlayer

@export var current_state : Ship_State = Ship_State.IDLE:
	set(new_value):
		current_state = new_value
		match current_state:
			Ship_State.IDLE:
				sprite_animation.play("default")
			Ship_State.MOVING:
				sprite_animation.play("flying")
			Ship_State.HIT:
				set_collision_layer_value(1, false)
				set_collision_mask_value(3, false)
				sprite_animation.play("explosion")
			Ship_State.INVULN:
				sprite_animation.play("default")
				animation_player.play("Flash")

#9. remaining regular variables
var ship_rotation_speed: int = 5
var ship_acceleration_speed: int = 200
var cooldown_time: int = 2
var isShooting: bool = false



#10. @onready variables

#11. _static_init()

#12. remaining static methods

#13. overridden built-in virtual methods:

#1. _init()

#2. _enter_tree()

#3. _ready()
func _ready() -> void:
	shield_sprite.visible = false
	if not start_position:
		start_position = Marker2D.new()
		start_position.position = position


#4. _process()
func _process(delta: float) -> void:
	if current_state == Ship_State.HIT:
		return
		
		
		
	var direction = Vector2.UP.rotated(rotation)
	var rotation_dir = Input.get_axis("Turn_Left", "Turn_Right")

	if Input.is_action_pressed("Accelerate"):
		position += direction * ship_acceleration_speed * delta
		current_state = Ship_State.MOVING
	else:
		current_state = Ship_State.IDLE

	rotation += rotation_dir * ship_rotation_speed * delta

	if Input.is_action_just_pressed("Shoot"):
		TryToShoot()




func TryToShoot():
	if isShooting:
		return

	isShooting = true
	Shoot()
	await get_tree().create_timer(SHOOT_DURATION).timeout
	isShooting = false


func Shoot():
	var bulletToSpawn = preload("uid://bysnr1qehew8s")
	GameManager.spawn_vfx(bulletToSpawn, shoot_point.global_position, rotation)


func _on_area_entered(area: Area2D) -> void:
	current_state = Ship_State.HIT


func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state == Ship_State.HIT:
		visible = false
		shield_sprite.visible = true
	respawn()


func respawn():
	GameManager.lose_health()
	emit_signal("Lost_Health")
	if GameManager.player_health <= 0:
		queue_free()
		GameManager.end_game()
		return
	else:
		await get_tree().create_timer(3).timeout
		visible = true
		current_state = Ship_State.INVULN
		rotation = 0
		position = start_position.position


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not current_state == Ship_State.HIT:
		wrap_around_viewport()


func wrap_around_viewport():
	var new_position = global_position
	var viewport_rect = get_viewport_rect()
	
	if global_position.x < viewport_rect.position.x - wrap_margin:
		new_position.x = viewport_rect.end.x + wrap_margin
	elif global_position.x > viewport_rect.end.x + wrap_margin:
		new_position.x = viewport_rect.position.x - wrap_margin
		
	if global_position.y < viewport_rect.position.y - wrap_margin:
		new_position.y = viewport_rect.end.y + wrap_margin
	elif global_position.y > viewport_rect.end.y + wrap_margin:
		new_position.y = viewport_rect.position.y - wrap_margin
	
	global_position = new_position


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	set_collision_layer_value(1, true)
	set_collision_mask_value(3, true)
	current_state = Ship_State.IDLE
