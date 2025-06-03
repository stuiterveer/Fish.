extends Control

@onready var score_label = $Score

func _ready():
	#GlobalVars.score_updated.connect(render_ui)
	if (GlobalVars.speed_upgrades_applied != GlobalVars.upgrade_amount || GlobalVars.size_upgrades_applied != GlobalVars.upgrade_amount):
		GlobalVars.player_score = 0
		$Protip.visible = true
	render_ui()

func _on_retry_button_button_up():
	GlobalVars.reset()
	get_tree().change_scene_to_file("res://Levels/gameplay.tscn")

func _on_exit_button_button_up():
	get_tree().quit()

func render_ui():
	score_label.text = "Score: " + str(GlobalVars.player_score)
