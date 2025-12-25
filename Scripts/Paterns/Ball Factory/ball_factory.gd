class_name BallFactory

func create(ball: Ball) -> PackedScene:
	if ball is DefaultBall:
		return preload("res://Scenes/Balls/DefaultBall.tscn")
	if ball is CriticalBall:
		return preload("res://Scenes/Balls/CriticalBall.tscn")
	if ball is DuplicatorBall:
		return preload("res://Scenes/Balls/DuplicatorBall.tscn")
	if ball is ChannelerBall:
		return preload("res://Scenes/Balls/ChannelerBall.tscn")
	return null
