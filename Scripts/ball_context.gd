extends Node

var balls := {
	DefaultBall : "Deafult ",
	CriticalBall : "Critical ",
	DuplicatorBall : "Duplicator"
}

func get_ball_name(ball) -> String: 
	return balls.get(ball)
