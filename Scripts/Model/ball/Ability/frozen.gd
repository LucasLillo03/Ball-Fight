class_name Frozen
extends ActivatableAbility

var _save_linear_veloccity : Vector2
var _save_angular_veloccity : float

func _init() -> void:
	super()
	ability_name = "Intermittent frozen"

func on_active() -> void: 
	_save_angular_veloccity = ball.angular_velocity
	_save_linear_veloccity = ball.linear_velocity
	
	ball.movement_locked = true
	ball.gravity_locked = true
	
	ball.linear_velocity = Vector2.ZERO
	ball.angular_velocity = 0.0
	
func on_desactive() -> void:
	ball.movement_locked = false
	ball.gravity_locked = false
	
	ball.linear_velocity = _save_linear_veloccity
	ball.angular_velocity = _save_angular_veloccity

func get_property() -> String: 
	var state := "active " if active else "desactive "
	return ability_name + ": " + state
