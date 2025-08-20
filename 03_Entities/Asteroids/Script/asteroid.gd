extends Area2D
class_name ASTEROID

@export var collision_shape: CollisionShape2D
@export var asteroid_sprite: Sprite2D
@export var explosion_particles: GPUParticles2D
@export var asteroid_size: = ASTEROID_SIZES.LARGE
@export var wrap_margin: float = 0
@export var debug: bool = false
@export var explosion_audio: AudioStreamPlayer2D


var particle_amount = 3
var camera_shake_intensity = 3

enum ASTEROID_SIZES{
	LARGE,
	MEDIUM,
	SMALL,
}

enum RADIUS{
	LARGE = 24,
	MEDIUM = 14,
	SMALL = 7,
}

enum SCALE{
	LARGE = 4,
	MEDIUM = 2,
	SMALL = 1
}

var speed := .5
var min_speed := .5
var max_speed := 1
var rotation_factor := 0.02
var screen_size := Vector2.ZERO

var large_astroid_dict = SceneManager.large_asteroid_sprites
var medium_astroid_dict = SceneManager.medium_asteroid_sprites
var small_astroid_dict = SceneManager.small_asteroid_sprites

var direction:= Vector2.ZERO
var large_asteroid_sprites = [large_astroid_dict["Large A"], large_astroid_dict["Large B"], large_astroid_dict["Large C"]]
var medium_asteroid_sprites = [medium_astroid_dict["Medium A"], medium_astroid_dict["Medium B"], medium_astroid_dict["Medium C"]]
var small_asteroid_sprites = [small_astroid_dict["Small A"], small_astroid_dict["Small B"], small_astroid_dict["Small C"]]

func _ready() -> void:
	explosion_particles.finished.connect(_clear_particles)
	screen_size = get_viewport_rect().size
	if not debug:
		speed = randf_range(min_speed, max_speed)
		direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	randomize()
	
	# Set the sprite
	match asteroid_size:
		ASTEROID_SIZES.LARGE:
			asteroid_sprite.texture = large_asteroid_sprites[randi() % large_asteroid_sprites.size()]
		ASTEROID_SIZES.MEDIUM:
			asteroid_sprite.texture = medium_asteroid_sprites[randi() % medium_asteroid_sprites.size()]
		ASTEROID_SIZES.SMALL:
			asteroid_sprite.texture = small_asteroid_sprites[randi() % small_asteroid_sprites.size()]


func _process(_delta: float) -> void:
	# move asteroid around 
	position += direction * speed
	rotation += rotation_factor


func _on_area_entered(area: Area2D) -> void:
	if area.name != "PlayerShip":
		area.queue_free()
		asteroid_hit()

func _clear_particles():
	queue_free()

func emit_particles():
	match asteroid_size:
		ASTEROID_SIZES.LARGE:
			particle_amount *= SCALE.LARGE
		ASTEROID_SIZES.MEDIUM:
			particle_amount *= SCALE.MEDIUM
		ASTEROID_SIZES.SMALL:
			particle_amount *= SCALE.SMALL

	explosion_particles.amount = particle_amount
	explosion_particles.global_position = global_position
	explosion_particles.emitting = true

func asteroid_hit():
	collision_shape.queue_free()
	asteroid_sprite.visible = false
	play_audio()
	emit_particles()
	match asteroid_size:
		ASTEROID_SIZES.LARGE:
			GameManager.add_score(1)
			GameManager.main.camera_shake(camera_shake_intensity * SCALE.LARGE)
			GameManager.main.spawn_asteroid(global_position, ASTEROID_SIZES.MEDIUM, debug)
			GameManager.main.spawn_asteroid(global_position, ASTEROID_SIZES.MEDIUM, debug)
		ASTEROID_SIZES.MEDIUM:
			GameManager.add_score(2)
			GameManager.main.camera_shake(camera_shake_intensity * SCALE.MEDIUM)
			GameManager.main.spawn_asteroid(global_position, ASTEROID_SIZES.SMALL, debug)
			GameManager.main.spawn_asteroid(global_position, ASTEROID_SIZES.SMALL, debug)
		ASTEROID_SIZES.SMALL:
			GameManager.add_score(3)
			GameManager.main.camera_shake(camera_shake_intensity * SCALE.SMALL)
			GameManager.main.spawn_asteroid(false, ASTEROID_SIZES.LARGE, debug)
	

func play_audio():
	explosion_audio.pitch_scale = randf_range(0.5, 1.5)
	explosion_audio.play()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
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
