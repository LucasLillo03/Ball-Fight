class_name IntermittentAbility
extends Ability

var active := false 

var timer : Timer 
var inactive_time := 5.0 
var active_time := 3.0

func timer_initialization() -> void: 
	timer = Timer.new()
	
	ball.add_child(timer)
	
	timer.wait_time = inactive_time
	timer.timeout.connect(_on_timeout)
	timer.start()

func rand_times(): 
	inactive_time = randf_range(2.0, 10.0)
	active_time = randf_range(2.0, 10.0)

func _on_timeout(): 
	active = !active 
	
	if active: 
		_active()
	else: 
		_desactive()
	
	timer.start()

func _active(): 
	_active_actions()
	timer.wait_time = active_time

func _desactive(): 
	_inactive_actions()
	timer.wait_time = inactive_time

func _active_actions() -> void: 
	print("this method must be implemented")

func _inactive_actions() -> void: 
	print("this method must be implemented")
