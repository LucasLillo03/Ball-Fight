class_name BallStats 
extends RefCounted

var radius : float
var damage : int
var color : Color 
var life : int 
var max_speed : float
# var clamp_speed_behavior : ClampSpeedBehavior

func rand_stats() -> void:
	randomize()
	
	radius = rand_radius()
	
	damage = randi_range(1, 10)
	
	color = Color(randf(),randf(),randf())
	
	_update_stats()

func rand_radius() -> float: 
	return randf_range(Constants.MIN_INITIAL_RADIUS, Constants.MAX_INITIAL_RADIUS)

func rand_damage() -> int: 
	return randi_range(Constants.MIN_BASE_DAMAGE, Constants.MAX_BASE_DAMAGE)

func _update_stats():
	#(MIN_INITIAL_RADIUS, MAX_INITIAL_RADIUS) -> (1.0, 100.0)
	var radius_to_percentage = func(x : float) -> float : return (1 + ((x - Constants.MIN_INITIAL_RADIUS) * 99) / (100 - Constants.MAX_INITIAL_RADIUS)) 
	#(1.0, 100.0) -> (MIN_INITIAL_LIFE, MAX_INITIAL_LIFE)
	var percentage_to_life = func(x : float) -> int: return floor(Constants.MIN_INITIAL_LIFE + ( (x-1) * (Constants.MAX_INITIAL_LIFE - Constants.MIN_INITIAL_LIFE) ) / 99)
	#(1.0, 100.0) -> (MIN_INITIAL_VELOCITY, MAX_INITIAL_VELOCITY)
	var percentage_to_speed = func(x : float) -> float: 
		var accumulated_initial_velocity = (Constants.MAX_INITIAL_VELOCITY + Constants.MIN_INITIAL_VELOCITY)
		var percentage_relation = (x-1) * (Constants.MAX_INITIAL_VELOCITY - Constants.MIN_INITIAL_VELOCITY)
		return accumulated_initial_velocity - (Constants.MIN_INITIAL_VELOCITY + percentage_relation / 99)
	 
	var transformed_radius : float = radius_to_percentage.call(radius)
	
	life = percentage_to_life.call(transformed_radius)
	
	max_speed = percentage_to_speed.call(transformed_radius)
	
	# if clamp_speed_behavior: clamp_speed_behavior.set_max_speed(max_speed)