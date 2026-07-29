class_name BallFactory
extends RefCounted

const BALL_SCENE = preload("res://Scenes/Balls/ball.tscn")

static func create_default_ball() -> Ball:
	return create_from_config(create_default_config())

static func create_random_ball() -> Ball:
	return create_from_config(create_rand_config())

static func create_rand_config() -> BallConfig:
	var ball_config = BallConfig.new()
	var stats := BallStats.new()

	stats.rand_stats()
	
	ball_config.stats = stats
	ball_config.ball_name = "RANDOM BALL"
	ball_config.speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, stats.max_speed)

	return ball_config

static func create_default_config() -> BallConfig:
	var ball_config = BallConfig.new()
	var stats := BallStats.new()

	stats.default_values()
	
	ball_config.stats = stats
	ball_config.ball_name = "SIMPLE BALL"
	ball_config.speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, stats.max_speed)

	return ball_config

static func create_from_config(config : BallConfig) -> Ball:

	var ball = BALL_SCENE.instantiate()

	ball.set_config(config)

	return ball
