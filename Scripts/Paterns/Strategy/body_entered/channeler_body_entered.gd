class_name ChannelerBodyEntered
extends BodyEnteredBehavior

var channeler_behavior : ChannelerAbility 

func _init(channeler : ChannelerAbility, parent : Node) -> void: 
	self.parent = parent 
	self.channeler_behavior = channeler
	
func body_entered(body : Node) -> void: 
	if body.is_in_group("harmful"):
		var mitigated_damage = parent.take_damage_behavior.take_damage(body, self)
		if channeler_behavior.shield_active: 
			parent.damage += round(mitigated_damage * channeler_behavior.boost_damage_factor)

	else: 
		if !shield_active: bound_sound_player.play()
	linear_velocity = clamp_speed_behavior.clamp_speed(linear_velocity)
