class_name BallFactory
extends RefCounted

const BALL_SCENE = preload("res://Scenes/Balls/ball.tscn")

static func create_default() -> Ball:
	var ball = BALL_SCENE.instantiate()
	
	_setup_default(ball)
	
	return ball

static func _setup_default(ball : Ball) -> void: 
	ball.ball_name = "SIMPLE BALL"
	
	ball.rand_stats()
	
	ball.clamp_speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, ball.max_speed)

static func create_from_config(config : BallConfig) -> Ball:

	var ball = BALL_SCENE.instantiate()

	ball.set_config(config)

	return ball
