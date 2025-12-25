class_name CriticalBall
extends Ball

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0  
const COLOR := Color.CRIMSON
const DAMAGE := 1
const BALL_NAME := "CRITICAL"

var last_damage : int

func _init() -> void:
	take_damage_behavior = DefaultTakeDamageBehavior.new()
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE

func get_damage(): 
	var critical_damage = damage * randi() % 10 
	
	last_damage = critical_damage
	
	return critical_damage

func get_ball_name() -> String: 
	return BALL_NAME

func get_properties() -> String: 
	var result := "Last Damage: " + str(last_damage)
	
	return result
