extends Node

var balls := {
	DefaultBall : "Deafult",
	CriticalBall : "Critical",
	DuplicatorBall : "Duplicator",
	ChannelerBall : "Channeler",
	StinkyBall : "Stinky"
}

var take_damage_collection :={
	DefaultTakeDamageBehavior : "Default",
	ShieldTakeDamage : "Shield"
}
func get_ball_name(ball) -> String: 
	return balls.get(ball)
