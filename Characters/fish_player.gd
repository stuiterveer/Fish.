extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var area_shape = $Area2D
@onready var wall_detection = $WallDetection

func _ready():
	var current_size = GlobalVars.player_size_min + (GlobalVars.size_upgrades_applied * ((GlobalVars.player_size_max - GlobalVars.player_size_min) / GlobalVars.upgrade_amount))
	sprite.scale.x = current_size
	sprite.scale.y = current_size
	area_shape.scale.x = current_size
	area_shape.scale.y = current_size
	wall_detection.scale.x = current_size
	wall_detection.scale.y = current_size

func _physics_process(_delta):
	var input_direction = Vector2(
		ceil(Input.get_action_strength("right"))-ceil(Input.get_action_strength("left")),
		ceil(Input.get_action_strength("down"))-ceil(Input.get_action_strength("up"))
	)
	
	velocity = input_direction * GlobalVars.player_speed
	
	update_animation_parameters(input_direction)
	
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		sprite.flip_h = (move_input.x > 0)


func _on_area_2d_body_entered(body):
	if (body.is_in_group("Enemy")):
		if (body.scale.x < sprite.scale.x):
			body.queue_free()
			GlobalVars.player_score += 1
		else:
			get_tree().change_scene_to_file("res://Levels/game_over.tscn")
