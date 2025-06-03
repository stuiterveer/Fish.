extends Node

signal score_updated
signal size_updated
signal speed_updated
signal day_updated

var base_speed = 100
var max_speed = 1000
var player_speed = base_speed : set = _set_speed
var max_upgrades = 10
var spawn_timer_min = 0.1
var spawn_timer_max = 1.5
var upgrade_amount = 10
var upgrade_costs = []
var player_size_max = 0.5
var player_size_min = 0.08
var current_size = player_size_min : set = _set_size
var enemy_size_max = 0.45
var enemy_size_min = 0.01
var player_score = 0 : set = _set_score
var speed_upgrades_applied = 0 : set = _apply_speed_upgrade
var size_upgrades_applied = 0 : set = _apply_size_upgrade
var current_day = 0 : set = _set_day
var days_max = 10

func reset():
	player_score = 0
	current_size = player_size_min
	player_speed = base_speed
	speed_upgrades_applied = 0
	size_upgrades_applied = 0
	current_day = 0

func calculate_upgrade_costs():
	var n1 : int = 1
	var n2 : int = 2
	var nth : int = 0
	var results = []
	
	results.append(n1) # first Fibonacci number is 0
	while results.size() < upgrade_amount:
		nth = n1 + n2
		n1 = n2
		n2 = nth
		results.append(n1)
	
	return results

func _ready():
	upgrade_costs = calculate_upgrade_costs()

func _set_size(value):
	current_size = value
	emit_signal("size_updated")

func _set_score(value):
	player_score = value
	emit_signal("score_updated")

func _set_speed(value):
	player_speed = value
	emit_signal("speed_updated")

func _apply_speed_upgrade(value):
	if (value == speed_upgrades_applied + 1):
		if (player_score >= upgrade_costs[speed_upgrades_applied]):
			player_score = player_score - upgrade_costs[speed_upgrades_applied]
			speed_upgrades_applied = value
			_set_speed(floor(base_speed + (speed_upgrades_applied * ((max_speed - base_speed) / upgrade_amount))))
	elif (value == 0):
		speed_upgrades_applied = value

func _apply_size_upgrade(value):
	if (value == size_upgrades_applied + 1):
		if (player_score >= upgrade_costs[size_upgrades_applied]):
			player_score = player_score - upgrade_costs[size_upgrades_applied]
			size_upgrades_applied = value
			_set_size(player_size_min + (size_upgrades_applied * ((player_size_max - player_size_min) / upgrade_amount)))
	elif (value == 0):
		size_upgrades_applied = value

func _set_day(value):
	current_day = value
	emit_signal("day_updated")
