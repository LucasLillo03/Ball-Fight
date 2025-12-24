class_name DefaultBall
extends Ball

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const COLOR := Color.DODGER_BLUE
const DAMAGE := 1

func _init() -> void:
	take_damage_behavior = DefaultTakeDamageBehavior.new()
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE
