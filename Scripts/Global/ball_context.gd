extends Node

var balls := {
	DefaultBall : "Deafult",
	ChannelerBall : "Channeler",
}

var abilities := {
	Invulnerability : true,
	DamageAccumulator : true,
	IntermittentFrozen : true
}
func get_ball_name(ball) -> String: 
	return balls.get(ball)
