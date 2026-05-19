

var boost_damage_factor := 2 #multiplicador de damage absorbido 

var shield_active := false 
var shield_timer : Timer 
var shield_collision : CollisionShape2D
var shield_value : int #cobertura del escudo

var _save_linear_velocity : Vector2
var _save_angular_velocity : float


var collision : CollisionShape2D

var parent : Node
var parent_take_damage : TakeDamageBehavior
var parent_clamp_speed : ClampSpeedBehavior  

#recibe una instancia de Ball
func setup(parent : Node, shield_value : int) -> void: 
	self.parent = parent
	self.shield_value = shield_value
	parent_clamp_speed = parent.clamp_speed_behavior
	parent_take_damage = parent.take_damage_behavior 
	
	collision = parent.collision
	
	shield_collision = CollisionShape2D.new()
	shield_collision.shape = collision.shape
	shield_collision.disabled = true 
	
	var shield_area = Area2D.new()
	shield_area.add_child(shield_collision)
	parent.add_child(shield_area)
	
	shield_timer = Timer.new()
	shield_timer.wait_time = 5.0 
	shield_timer.autostart = true 
	shield_timer.timeout.connect(_on_shield_timer_timeout)

func _on_shield_timer_timeout() -> void:
	shield_active = !shield_active
	
	if shield_active: _active_shield()
	else: _desactive_shield()
	
	shield_timer.start()

func _active_shield() -> void:
	_save_angular_velocity = parent.angular_velocity
	_save_linear_velocity = parent.linear_velocity
	
	shield_collision.disabled = false 
	
	parent.freeze = true
	parent.linear_velocity = Vector2.ZERO
	parent.angular_velocity = 0.0
	
	parent.take_damage_behavior = ShieldTakeDamage.new(shield_value)
	parent.clamp_speed_behavior = StaticClampSpeed.new()
	
	#cambiar apariencia al activar el escudo
	parent.update_visual()

func _desactive_shield() -> void:
	boost_damage_factor += 1
	
	shield_collision.disabled = true 
	
	parent.freeze = false 
	parent.linear_velocity = _save_linear_velocity
	parent.angular_velocity = _save_angular_velocity
	
	parent.take_damage_behavior = parent_take_damage
	parent.clamp_speed_behavior = parent_clamp_speed
	
	parent.update_visual()
