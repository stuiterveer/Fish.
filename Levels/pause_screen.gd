extends Node2D

var paused = false

func _process(_delta):
	if (Input.is_action_just_pressed("pause")):
		pause_menu()

func pause_menu():
	paused = !paused
	get_tree().paused = paused
	$ColorRect.visible = paused
	$Label.visible = paused
