extends Node2D
class_name GameScript

@export var safe_zone: CollisionShape2D
@export var start_position: Marker2D
@export var difficulty: GameManager.DIFFICULTY
var viewport: Vector2


func _ready() -> void:
	GameManager.difficulty_selection = difficulty
	viewport = get_viewport_rect().size
	GameManager.start_game(viewport, safe_zone, start_position)
