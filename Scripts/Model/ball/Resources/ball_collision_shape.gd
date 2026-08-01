class_name BallCollisionShape
extends CollisionShape2D

var ball : Ball

func _ready() -> void:
	ball = get_parent()
	ball.stats.radius_changed.connect(update_collision)
	update_collision(ball.stats.radius)

func update_collision(new_radius : float) -> void:
	shape.radius = new_radius
