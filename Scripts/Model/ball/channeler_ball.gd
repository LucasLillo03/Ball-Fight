class_name ChannelerBall
extends Ball

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const COLOR := Color.ORANGE
const DAMAGE := 1

func _init() -> void:
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	abilities.append(Invulnerability.new())
	color = COLOR
	damage = DAMAGE
	
	for ability in abilities:
		ability.setup(self)
