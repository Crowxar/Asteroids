class_name OldSaveData extends Resource

@export var player_name : String = "Thomas"
@export var level : int = 1
@export var health : float = 1.0
@export var skip_tutorial : bool = false
@export var position : Vector2 = Vector2.ZERO
@export var favorite_color : Color = Color.FOREST_GREEN
@export var inventory : Array = [
	"Health Potion",
	"Stamina Potion",
	"Mana Potion",
]
@export var equipment : Dictionary = {
	"main" : "Sword",
	"off" : "Shield",
	"body" : "Armor",
}
