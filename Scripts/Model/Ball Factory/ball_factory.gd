class_name BallFactory
extends RefCounted

const BALL_SCENE = preload("res://Scenes/Balls/ball.tscn")

func create(ball: Ball) -> Ball: 
	if ball is DefaultBall: 
		return create_default()
	if ball is ChannelerBall: 
		return create_channeler()
	return null

static func create_default() -> Ball:
	var ball = BALL_SCENE.instantiate()
	
	_setup_default(ball)
	
	return ball

static func create_channeler() -> Ball:

	var ball = BALL_SCENE.instantiate()

	_setup_channeler(ball)

	return ball

static func _setup_default(ball : Ball) -> void: 
	ball.ball_name = "SIMPLE BALL"
	
	ball.rand_stats()
	
	ball.clamp_speed_behavior = AcceleratedAndLimited.new(ball.BOOST_FACTOR, ball.max_speed)
	
static func _setup_channeler(ball : Ball):
	ball.ball_name = "CHANNELER"

	ball.rand_stats()

	ball.clamp_speed_behavior = AcceleratedAndLimited.new(ball.BOOST_FACTOR, ball.max_speed)

	ball.add_ability(Invulnerability.new())
	ball.add_ability(DamageAccumulator.new())
	ball.add_ability(Frozen.new())

static func create_from_config(config : BallConfig) -> Ball:

	var ball = BALL_SCENE.instantiate()

	ball.set_config(config)

	return ball
