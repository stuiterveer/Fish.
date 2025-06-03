extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

var move_speed : int
var move_direction : int

func init(direction : int):
	move_speed = (float(randi_range(5, GlobalVars.max_upgrades * 10)) / 10) * GlobalVars.base_speed
	move_direction = direction

func _physics_process(_delta):
	var input_direction = Vector2(move_direction, 0)
	
	velocity = input_direction * move_speed
	
	update_animation_parameters(input_direction)
	
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		sprite.flip_h = (move_input.x > 0)


