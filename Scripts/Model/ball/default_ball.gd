class_name DefaultBall
extends Ball

const BALL_NAME = "DEFAULT"

func _init() -> void:
	rand_stats()
	ball_name = BALL_NAME
	
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, max_speed)
