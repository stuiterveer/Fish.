extends Control

@onready var points = $Points
@onready var speed_upgrades = $SpeedUpgrades
@onready var size_upgrades = $SizeUpgrades
@onready var upgrade_speed = $UpgradeSpeed
@onready var upgrade_size = $UpgradeSize

func _ready():
	GlobalVars.score_updated.connect(update_points)
	GlobalVars.speed_updated.connect(update_speed)
	GlobalVars.size_updated.connect(update_size)
	update_points()
	update_speed()
	update_size()

func _on_button_button_up():
	if (GlobalVars.current_day < GlobalVars.days_max):
		get_tree().change_scene_to_file("res://Levels/gameplay.tscn")
	else:
		get_tree().change_scene_to_file("res://Levels/game_over.tscn")

func update_points():
	points.text = "Upgrade points remaining: " + str(GlobalVars.player_score)

func update_speed():
	speed_upgrades.text = str(GlobalVars.speed_upgrades_applied) + " applied"
	if (GlobalVars.speed_upgrades_applied < GlobalVars.max_upgrades):
		upgrade_speed.text = "Upgrade for " + str(GlobalVars.upgrade_costs[GlobalVars.speed_upgrades_applied])
	else:
		upgrade_speed.text = "Fully upgraded!"

func update_size():
	size_upgrades.text = str(GlobalVars.size_upgrades_applied) + " applied"
	if (GlobalVars.size_upgrades_applied < GlobalVars.max_upgrades):
		upgrade_size.text = "Upgrade for " + str(GlobalVars.upgrade_costs[GlobalVars.size_upgrades_applied])
	else:
		upgrade_size.text = "Fully upgraded!"

func _on_upgrade_speed_button_up():
	GlobalVars.speed_upgrades_applied += 1

func _on_upgrade_size_button_up():
	GlobalVars.size_upgrades_applied += 1
