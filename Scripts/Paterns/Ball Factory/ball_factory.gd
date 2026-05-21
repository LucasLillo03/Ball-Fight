class_name BallFactory

const BALL_SCENE = preload("res://Scenes/Balls/ball.tscn")

func create(ball: Ball) -> Ball: 
	if ball is DefaultBall: 
		return BALL_SCENE.instantiate()
	if ball is ChannelerBall: 
		return create_channeler()
	return null

func create_channeler() -> Ball:

	var ball = BALL_SCENE.instantiate()

	setup_channeler(ball)

	return ball

func setup_channeler(ball : Ball):
	ball.ball_name = "CHANNELER"

	ball.rand_stats()

	ball.clamp_speed_behavior = AcceleratedAndLimited.new(ball.BOOST_FACTOR, ball.max_speed)

	ball.add_ability(Invulnerability.new())

func create_from_config(config : BallConfig) -> Ball:

	var ball = BALL_SCENE.instantiate()

	ball.ball_name = config.ball_name

	for ability in config.abilities:
		ball.add_ability(ability.new())

	return ball
