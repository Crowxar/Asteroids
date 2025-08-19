extends CanvasLayer

@export var life_one: TextureRect
@export var life_two: TextureRect
@export var life_three: TextureRect
@export var score_label: Label


func _ready() -> void:
	GameManager.score_update.connect(player_score_updated)

func _on_player_ship_lost_health() -> void:
	if GameManager.player_health == 2:
		life_three.visible = false
	if GameManager.player_health == 1:
		life_two.visible = false
	if GameManager.player_health == 0:
		life_one.visible = false


func player_score_updated():
	score_label.text = ("Score: %s " % str(GameManager.player_score))
