class_name DefaultBall
extends Ball

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const COLOR := Color.DODGER_BLUE
const DAMAGE := 1
const BALL_NAME = "DEFAULT"

func _init() -> void:
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE

func get_ball_name() -> String: 
	return BALL_NAME

func get_properties() -> String: 
	var result := "im a dummy ball" 
	
	return result
