extends Node

signal score_update

var player_health: int = 3
var asteroid_count: int = 10
var spawn_pos: Vector2
var difficulty_selection = DIFFICULTY.EASY

var player_score: int
var player_high_score: int
var original_high_score: int

var new_high_score: bool = false

var config_handler
var ui_scene

var main
var viewport
var safe_zone
var start_position

enum DIFFICULTY {
	EASY = 5,
	NORMAL = 15,
	HARD = 30,
}

enum ASTEROID_COUNT {
	EASY = 5,
	NORMAL = 15,
	HARD = 30,
}

func _ready() -> void:
	original_high_score = config_handler.load_high_score()
	player_health = 3
	player_score = 0
	player_high_score = 0
	
	
func lose_health():
	player_health -= 1

func end_game():
	if player_high_score > original_high_score:
		original_high_score = player_high_score
		new_high_score = true
		config_handler.save_high_score(player_high_score)
	ui_scene.end_game_screen(new_high_score)


func add_score():
	player_score += 1
	if player_score >= player_high_score:
		player_high_score = player_score
	emit_signal("score_update")

func spawn_vfx(vfxToSpawn: Resource, position: Vector2, rotation: float = 0):
	var vfx_instance = vfxToSpawn.instantiate()
	vfx_instance.global_position = position
	vfx_instance.rotation = rotation
	get_tree().get_root().add_child(vfx_instance)

	return vfx_instance


func spawn_asteroid(global_position, ASTEROID_SIZE, debug):
	if global_position:
		main.spawn_asteroid(global_position, ASTEROID_SIZE, debug)
	else:
		spawn_pos = main.select_spawn(viewport, safe_zone, start_position)
		main.spawn_asteroid(spawn_pos, ASTEROID_SIZE, debug)
