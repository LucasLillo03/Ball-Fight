class_name TimedActivation
extends ActivationStrategy

var active_time : float
var inactive_time : float

var timer : Timer 
var active := false

func concrete_setup(): 
	timer = Timer.new()
	
	ball.add_child(timer)
	
	timer.wait_time = inactive_time
	timer.timeout.connect(_on_timeout)
	timer.start()
	
func rand_stats(): 
	inactive_time = randf_range(2.0, 10.0)
	active_time = randf_range(2.0, 10.0)
	
func _on_timeout(): 
	active = !active 
	
	if active: 
		try_active()
	else: 
		try_desactive()
	
	timer.start()

func try_active(): 
	super()
	
	timer.wait_time = active_time

func try_desactive(): 
	super()
	
	timer.wait_time = inactive_time

func get_copy() -> ActivationStrategy: 
	var copy = TimedActivation.new()
	copy.active_time = active_time
	copy.inactive_time = inactive_time
	
	return copy
