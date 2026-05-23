extends Node

var balls := {
	DefaultBall : "Deafult",
	ChannelerBall : "Channeler",
}

func get_ball_name(ball) -> String: 
	return balls.get(ball)
