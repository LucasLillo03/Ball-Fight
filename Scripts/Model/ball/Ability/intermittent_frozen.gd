class_name IntermittentFrozen
extends IntermittentAbility

var _save_linear_veloccity : Vector2
var _save_angular_veloccity : float

func on_ready() -> void: 
	rand_times()
	
	ability_name = "Intermittent frozen"
	
	timer_initialization()

func _active_actions() -> void: 
	_save_angular_veloccity = ball.angular_velocity
	_save_linear_veloccity = ball.linear_velocity
	
	ball.movement_locked = true
	ball.gravity_locked = true
	
	ball.linear_velocity = Vector2.ZERO
	ball.angular_velocity = 0.0
	
func _inactive_actions() -> void:
	ball.movement_locked = false
	ball.gravity_locked = false
	
	ball.linear_velocity = _save_linear_veloccity
	ball.angular_velocity = _save_angular_veloccity

func get_property() -> String: 
	var state := "active in " if !active else "desactive in "
	return ability_name + ": " + state + str(int(timer.time_left))
