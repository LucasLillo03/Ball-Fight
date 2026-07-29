class_name BallFactory
extends RefCounted

const BALL_SCENE = preload("res://Scenes/Balls/ball.tscn")

static func create_default_ball() -> Ball:
	var ball = BALL_SCENE.instantiate()
	
	_setup_default(ball)
	
	return ball

static func create_random_ball() -> Ball:
	var ball = create_from_config(create_rand_config())

	ball.ball_name = "RANDOM BALL"

	ball.clamp_speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, ball.max_speed)

	return ball

static func create_rand_config() -> BallConfig:
	var ball_config = BallConfig.new()
	var stats := BallStats.new()

	stats.rand_stats()
	
	ball_config.damage = stats.damage
	ball_config.radius = stats.radius
	ball_config.ball_name = "SIMPLE BALL"
	ball_config.color = stats.color
	ball_config.speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, stats.max_speed)

	return ball_config

static func _setup_default(ball : Ball) -> void: 
	ball.ball_name = "SIMPLE BALL"
	
	ball.clamp_speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, ball.max_speed)


static func create_from_config(config : BallConfig) -> Ball:

	var ball = BALL_SCENE.instantiate()

	ball.set_config(config)

	return ball
