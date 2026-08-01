class_name BallStats 
extends RefCounted

var radius: float:
	set(value):
		radius = value
		update_stats()
		radius_changed.emit(value)

var damage : int
var color : Color:
	set(value):
		color = value
		color_changed.emit(value)
var life : int: 
	set(value): 
		life = value 
		life_changed.emit(value)
		if (value <= 0): 
			dead.emit()
var max_speed : float
# var clamp_speed_behavior : ClampSpeedBehavior

signal radius_changed(radius : float)
signal color_changed(color : Color)
signal life_changed(life : int)
signal dead()

func default_values() -> void: 
	radius = Constants.DEFAULT_STATS.radius
	damage = Constants.DEFAULT_STATS.damage
	color = Constants.DEFAULT_STATS.color
	life = Constants.DEFAULT_STATS.life
	max_speed = Constants.DEFAULT_STATS.max_speed

func rand_stats() -> void:
	randomize()
	
	radius = rand_radius()
	
	damage = randi_range(1, 10)
	
	color = Color(randf(),randf(),randf())
	
	update_stats()

func rand_radius() -> float: 
	return randf_range(Constants.MIN_INITIAL_RADIUS, Constants.MAX_INITIAL_RADIUS)

func rand_damage() -> int: 
	return randi_range(Constants.MIN_BASE_DAMAGE, Constants.MAX_BASE_DAMAGE)

func update_stats():
	if radius <= 0.0:
		return
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
