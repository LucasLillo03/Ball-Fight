class_name AcceleratedAndLimited
extends ClampSpeedBehavior

var boost_factor: float 
var max_speed: float   

func _init(boost_factor : float, max_speed : float):
	self.boost_factor = boost_factor
	self.max_speed = max_speed

func clamp_speed(velocity : Vector2) -> Vector2:
	velocity *= boost_factor
	var speed := velocity.length()
	if speed <= 0.0:
		return velocity
	if speed > max_speed:
		return velocity * (max_speed / speed)
	return velocity
