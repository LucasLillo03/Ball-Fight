class_name BallFactory

func create(ball: Ball) -> PackedScene:
	if ball is DefaultBall:
		return preload("res://Scenes/DefaultBall.tscn")
	if ball is CriticalBall:
		return preload("res://Scenes/CriticalBall.tscn")
	return null
