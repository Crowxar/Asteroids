extends CanvasLayer

@export var life_one: TextureRect
@export var life_two: TextureRect
@export var life_three: TextureRect
@export var score_label: Label
@export var high_label: Label

@export var end_over_high_score: Label
@export var end_over_current_score: Label
@export var new_high_score_label: Label
@export var end_restart_button: Button
@export var end_main_menu_button: Button

@export var in_game_ui: Control
@export var game_over_ui: Control


func _ready() -> void:
	in_game_ui.visible = true
	game_over_ui.visible = false
	GameManager.ui_scene = self
	GameManager.score_update.connect(player_score_updated)
	high_label.text = ("Best: %s " % str(GameManager.original_high_score))


func _on_player_ship_lost_health() -> void:
	if GameManager.player_health == 2:
		life_three.visible = false
	if GameManager.player_health == 1:
		life_two.visible = false
	if GameManager.player_health == 0:
		life_one.visible = false


func end_game_screen(new_high_score):
	end_over_current_score.text = ("Your Score: %s " % str(GameManager.player_score))
	end_over_high_score.text = ("High Score: %s " % str(GameManager.original_high_score))
	in_game_ui.visible = false
	game_over_ui.visible = true
	if new_high_score:
		new_high_score_label.visible = true


func player_score_updated():
	score_label.text = ("Score: %s " % str(GameManager.player_score))
	if GameManager.player_high_score > GameManager.original_high_score:
		high_label.text = ("Best: %s " % str(GameManager.player_high_score))



func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file(SceneManager.menu_dict["main menu"])
