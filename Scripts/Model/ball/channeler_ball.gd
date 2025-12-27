class_name ChannelerBall
extends Ball

@export var boost_damage_factor := 2

@onready var shield_timer = $ShieldTimer
@onready var shield_collision = $ShieldArea/ShieldCollision

var shield_active = false
var _save_linear_veloccity : Vector2
var _save_angular_veloccity : float

const BOOST_FACTOR: float = 1.15   
const MAX_SPEED: float = 600.0   
const COLOR := Color.ORANGE
const SHIELD_COLOR := Color.DARK_ORANGE
const DAMAGE := 1
const SHIELD_VALUE := 1
const BALL_NAME := "CHANNELER" 


func _init() -> void:
	take_damage_behavior = DefaultTakeDamageBehavior.new()
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	color = COLOR
	damage = DAMAGE

func _on_ready() -> void:
	shield_collision.shape = col.shape
	shield_collision.disabled = true 

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("harmful"):
		var mitigated_damage = take_damage_behavior.take_damage(body, self)
		if shield_active: 
			damage += round(mitigated_damage * boost_damage_factor)

	else: 
		if !shield_active: bound_sound_player.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)

func get_damage() -> int:
	if shield_active: return 0
	
	var current_damage = damage
	
	damage = DAMAGE
	
	return current_damage
	

func _active_shield() -> void:
	_save_angular_veloccity = angular_velocity
	_save_linear_veloccity = linear_velocity
	
	shield_collision.disabled = false 
	
	freeze = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	
	take_damage_behavior = ShieldTakeDamage.new(SHIELD_VALUE)
	clamp_speed_behavior = StaticClampSpeed.new()
	set_color(SHIELD_COLOR)
	_update_visual()

func _desactive_shield() -> void:
	boost_damage_factor += 1
	
	shield_collision.disabled = true 
	
	freeze = false 
	linear_velocity = _save_linear_veloccity
	angular_velocity = _save_angular_veloccity
	
	take_damage_behavior = DefaultTakeDamageBehavior.new()
	clamp_speed_behavior = AcceleratedAndLimited.new(BOOST_FACTOR, MAX_SPEED)
	set_color(COLOR)
	_update_visual()

func _on_shield_timer_timeout() -> void:
	shield_active = !shield_active
	
	if shield_active: _active_shield()
	else: _desactive_shield()
	
	shield_timer.start()

func _on_shield_area_body_entered(body: Node2D) -> void:
	if body == self: return 
	_on_body_entered(body)

func get_ball_name() -> String: 
	return BALL_NAME

func get_properties() -> String: 
	var shield_time = shield_timer.time_left if !shield_active else 0.00
	var result := "Shield Timer: "+ String.num(shield_time, 2) +"\nAcumulated Damage: " + str(damage) + "\nMultiplier: " + str(boost_damage_factor)
	
	return result
