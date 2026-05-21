extends Node

var balls := {
	DefaultBall : "Deafult",
	CriticalBall : "Critical",
	DuplicatorBall : "Duplicator",
	ChannelerBall : "Channeler",
	StinkyBall : "Stinky"
}

func get_ball_name(ball) -> String: 
	return balls.get(ball)
