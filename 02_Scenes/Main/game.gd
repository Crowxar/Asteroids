extends Node2D

@export var safe_zone: CollisionShape2D
@export var start_position: Marker2D
@export var camera: Camera2D
var camera_original_offset: Vector2
var camera_shake_noise: FastNoiseLite
var viewport: Vector2
var spawn_pos: Vector2
var asteroid_count: int


func _ready() -> void:
	GameManager.main = self
	var difficulty = GameManager.game_difficulty
	camera_shake_noise = FastNoiseLite.new()
	viewport = get_viewport_rect().size
	match difficulty:
		GameManager.DIFFICULTY.EASY:
			asteroid_count = 5
		GameManager.DIFFICULTY.NORMAL:
			asteroid_count = 10
		GameManager.DIFFICULTY.HARD:
			asteroid_count = 15
	start_game(viewport, safe_zone, start_position, asteroid_count)


func start_game(viewport, safe_zone, start_position, asteroid_count = 1):
	for asteroid in asteroid_count:
		spawn_pos = select_spawn(viewport, safe_zone, start_position)
		spawn_asteroid(spawn_pos, ASTEROID.ASTEROID_SIZES.LARGE)


func spawn_asteroid(position, size = ASTEROID.ASTEROID_SIZES.LARGE, debug_mode: bool = false):
	var asteroid_instance
	match size:
		ASTEROID.ASTEROID_SIZES.LARGE:
			asteroid_instance = SceneManager.scene_dict["large asteroid"].instantiate()
		ASTEROID.ASTEROID_SIZES.MEDIUM:
			asteroid_instance = SceneManager.scene_dict["medium asteroid"].instantiate()
		ASTEROID.ASTEROID_SIZES.SMALL:
			asteroid_instance = SceneManager.scene_dict["small asteroid"].instantiate()
	if not position:
		position = select_spawn(viewport, safe_zone, start_position)
	asteroid_instance.global_position = position
	asteroid_instance.asteroid_size = size
	asteroid_instance.debug = debug_mode

	get_tree().get_current_scene().call_deferred("add_child", asteroid_instance)


func select_spawn(viewport, safe_zone, start_position):
	var max_attempts = 100  # Prevent infinite loops
	var attempts = 0
	while attempts < max_attempts:
		spawn_pos = Vector2(
				randf_range(0, viewport.x),
				randf_range(0, viewport.y)
			)
		if spawn_pos.distance_to(start_position.position) > safe_zone.shape.radius:
			return spawn_pos
		attempts += 1
	print_debug("Error Spawning Asteroid")
	return Vector2.ZERO


func camera_shake(intensity):
	var camera_shake_tween = get_tree().create_tween()
	camera_shake_tween.tween_method(update_camera_shake, intensity, 0.0, 0.5)
	
func update_camera_shake(intensity: float):
	var camera_offset = camera_shake_noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	camera.offset.x = camera_original_offset.x + camera_offset
	camera.offset.y = camera_original_offset.y + camera_offset
