extends Control


@export var coins_label : Label
@export var increase : Button
@export var decrease : Button
@export var save : Button
@export var load : Button
@export var add_health : Button
@export var sub_health : Button
@export var health : ProgressBar

var coins: int = 0
var save_data = Data.new()


func save_game(save_path: String, save_data: Resource):
	var data = ResourceSaver.save(save_data, save_path)
	
	if data != OK:
		print_debug("Error Saving Game: " + data)
		
		
func load_game(save_path: String):
	var loaded_data = ResourceLoader.load(save_path)
	
	if loaded_data != null and loaded_data is Resource:
		return loaded_data
	else:
		print_debug("Error Loading Game")
		return null


func _on_increase_pressed() -> void:
	update_coins(1)

func _on_decrease_pressed() -> void:
	update_coins(-1)

func update_coins(value):
	coins += value
	save_data.coins = coins
	coins_label.text = "Coins: " + str(coins)

func _on_save_pressed() -> void:
	save_game("res://saves/save_data.res", save_data)


func _on_load_pressed() -> void:
	var loaded_data = load_game("res://saves/save_data.res")
	if loaded_data:
		coins = loaded_data.coins
		health.value = loaded_data.health
		change_health(0)
		update_coins(0)


func _on_add_health_pressed() -> void:
	change_health(5)


func _on_sub_health_pressed() -> void:
	change_health(-5)


func change_health(value):
	health.value += value
	save_data.health = health.value
