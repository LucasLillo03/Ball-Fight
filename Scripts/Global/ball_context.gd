extends Node

var balls := {
	DefaultBall : "Deafult",
	ChannelerBall : "Channeler",
}

var abilities := {
	Invulnerability : true,
	DamageAccumulator : true,
	Frozen : true,
	BallCreator : true
}

var activationStrategies := {
	TimedActivation : true
}

func get_ball_name(ball) -> String: 
	return balls.get(ball)
