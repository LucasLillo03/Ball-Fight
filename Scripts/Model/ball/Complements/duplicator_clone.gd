class_name DuplicatorClone
extends Ball

var parent : DuplicatorBall

func setup(parent : DuplicatorBall) -> void:
	self.parent = parent


	clamp_speed_behavior = AcceleratedAndLimited.new(parent.BOOST_FACTOR, parent.max_speed)
	color = parent.color
	damage = parent.DAMAGE

func die(): 
	queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("harmful") && body != parent:
		pass
	else: 
		bound_sound_player.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)
