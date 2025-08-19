class_name Player_Bullet
extends Area2D


var speed: int = 350
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	direction = Vector2.UP.rotated(rotation)
	

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
