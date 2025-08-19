extends Node

signal score_update

var player_health: int = 3
var asteroid_count: int = 10
var spawn_pos: Vector2
var difficulty_selection = DIFFICULTY.EASY
var player_score: int = 0


enum DIFFICULTY {
	EASY,
	NORMAL,
	HARD,
}


func lose_health():
	player_health -= 1

func add_score():
	player_score += 1
	emit_signal("score_update")

func spawn_vfx(vfxToSpawn: Resource, position: Vector2, rotation: float = 0):
	var vfx_instance = vfxToSpawn.instantiate()
	vfx_instance.global_position = position
	vfx_instance.rotation = rotation
	get_tree().get_root().add_child(vfx_instance)

	return vfx_instance


func spawn_asteroid(position: Vector2, size = ASTEROID.ASTEROID_SIZES.LARGE):
	var asteroid_instance = SceneManager.scene_dict["asteroid"].instantiate()
	asteroid_instance.global_position = position
	asteroid_instance.asteroid_size = size

	get_tree().get_root().call_deferred("add_child", asteroid_instance)


func start_game(viewport, safe_zone, start_position):
	match difficulty_selection:
		DIFFICULTY.EASY:
			asteroid_count = 5
		DIFFICULTY.NORMAL:
			asteroid_count = 15
		DIFFICULTY.HARD:
			asteroid_count = 30
		
	for asteroid in asteroid_count:
		spawn_pos = select_spawn(viewport, safe_zone, start_position)
		spawn_asteroid(spawn_pos, ASTEROID.ASTEROID_SIZES.LARGE)


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
