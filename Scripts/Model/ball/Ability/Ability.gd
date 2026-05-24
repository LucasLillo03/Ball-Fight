class_name Ability
extends RefCounted

var requires_update := false 
var ball : Node 
static var ability_name := "No name"

func setup(ball) -> void: 
	self.ball = ball
	
func on_ready() -> void: 
	pass 

func on_update(delta):
	pass

func pre_take_damage(damage_context : DamageContext) -> void: 
	pass 

func on_take_damage(damage_context : DamageContext) -> int:
	return damage_context.amount

func post_take_damage(damage_context : DamageContext) -> void:
	pass

func on_attack(target):
	pass

func get_damage(damage_context : DamageContext) -> int:
	return damage_context.amount

func on_death():
	pass

static func get_ablity_name() -> String:
	return ability_name

func get_property() -> String: 
	return "No property"
