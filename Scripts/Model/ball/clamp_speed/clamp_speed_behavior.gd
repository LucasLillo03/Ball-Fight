class_name ClampSpeedBehavior
extends Object

var max_speed : float

func clamp_speed(velocity : Vector2) -> Vector2:
	push_error("Método 'clamp_speed' no implementado en la subclase.")
	return velocity

func set_max_speed(max_speed : float) -> void: 
	self.max_speed = max_speed
