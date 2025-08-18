extends Area2D

@export var shoot_point: Marker2D

var ship_rotation_speed: int = 5
var ship_acceleration_speed: int = 200
var cooldown_time: int = 2


enum Ship_State {
	IDLE,
	MOVING,
	HIT,
}


@export var current_state : Ship_State = Ship_State.IDLE:
	set(new_value):
		match current_state:
			Ship_State.IDLE:
				pass
			Ship_State.MOVING:
				pass


func _process(delta: float) -> void:
	var direction = Vector2.UP.rotated(rotation)
	var rotation_dir = Input.get_axis("Turn_Left", "Turn_Right")

	if Input.is_action_pressed("Accelerate"):
		position += direction * ship_acceleration_speed * delta

	rotation += rotation_dir * ship_rotation_speed * delta
	
	match Ship_State:
		Ship_State.IDLE:
			pass
		Ship_State.MOVING:
			pass
