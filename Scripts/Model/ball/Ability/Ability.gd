class_name Ability
extends RefCounted

var requires_update := false 
var ball : Node 
var ability_name := "No name"

signal ball_asigned

func setup(ball) -> void: 
	self.ball = ball
	ball_asigned.emit()

func on_ready() -> void: 
	pass 
	
func on_update(delta):
	pass

func on_take_damage(damage_context : DamageContext) -> int:
	return damage_context.amount

func on_attack(target):
	pass

func get_damage(damage_context : DamageContext) -> int:
	return damage_context.amount

func on_death():
	pass

func get_ablity_name() -> String:
	return ability_name

func get_property() -> String: 
	return "No property"
