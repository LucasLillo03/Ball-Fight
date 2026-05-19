class_name Ability
extends Resource

var requires_update := false 
var ball : Node 

func setup(ball) -> void: 
	self.ball = ball
	
func on_ready() -> void: 
	pass 

func on_update(delta):
	pass

func on_take_damage(damage_context : DamageContext) -> int:
	return damage_context.amount

func on_attack(target):
	pass

func get_damage(damage):
	return damage

func on_death():
	pass
