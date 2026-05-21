class_name ChannelerBall
extends Ball
  
const NAME := "CHANNELER"

func _init() -> void:
	ball_name = NAME
	
	rand_stats()
	
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, max_speed)
	
	abilities.append(Invulnerability.new())
	
	for ability in abilities:
		ability.setup(self)
