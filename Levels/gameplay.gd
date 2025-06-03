extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var scores_label = $Score

func _ready():
	randomize()
	scores_label.text = str(GlobalVars.player_score)
	GlobalVars.current_day += 1
	$CurrentDay.text = str(GlobalVars.current_day)
	GlobalVars.score_updated.connect(update_score)
	spawn_timer.wait_time = randf_range(GlobalVars.spawn_timer_min, GlobalVars.spawn_timer_max)
	spawn_timer.start()

func _process(_delta):
	$TimeRemaining.text = str(ceil($Timer.time_left))

func spawn_enemy():
	# Prepare the spawn
	var enemy_fish = preload("res://Characters/fish_enemy.tscn").instantiate()
	
	# Scale the fish
	#var enemy_scale = randf_range(GlobalVars.enemy_size_min * GlobalVars.current_size, GlobalVars.enemy_size_max * GlobalVars.current_size)
	var enemy_scale = randf_range(GlobalVars.enemy_size_min, min(GlobalVars.enemy_size_max, GlobalVars.current_size * 3))
	enemy_fish.scale.x = enemy_scale
	enemy_fish.scale.y = enemy_scale
	
	# Set the direction of the fish
	var direction : int
	if (randi() % 2 == 0):
		direction = -1
	else:
		direction = 1
	enemy_fish.init(direction)
	
	# Position the fish
	# Calculate enemy size
	var enemy_size = ceil(enemy_fish.get_node("Sprite2D").texture.get_width() * enemy_scale)
	# Make enemy spawn outside the screen but as close to the edge as possible
	var enemy_distance = ceil(enemy_size / 2)
	# Place on the left or right side of the screen depending on movement direction
	var enemy_x : int
	if (direction == 1):
		enemy_x = 0 - enemy_distance
	else:
		enemy_x = 1920 + enemy_distance
	# Spawn in random position along Y axis
	var enemy_y = randi() % 1080
	
	enemy_fish.position = Vector2(enemy_x, enemy_y)
	
	add_child(enemy_fish)

func _on_spawn_timer_timeout():
	spawn_enemy()
	spawn_timer.wait_time = randf_range(GlobalVars.spawn_timer_min, GlobalVars.spawn_timer_max)
	spawn_timer.start()

func update_score():
	scores_label.text = str(GlobalVars.player_score)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Levels/upgrades.tscn")
