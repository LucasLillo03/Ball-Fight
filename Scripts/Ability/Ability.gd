class_name Ability
extends RefCounted

var requires_update := false 
var ball : Node 
var ability_name := "No name"

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

func get_property() -> String: 
	return "No property"
