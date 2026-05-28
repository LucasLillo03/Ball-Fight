class_name Ability
extends RefCounted

var requires_update := false 
var ball : Ball 
var ability_name := "No name"

var tags : Array[Constants.TAG] = []
var dependencies : Array[Constants.TAG] = [] 

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

func get_dependencies() -> Array[Constants.TAG]: 
	return dependencies
	
func get_tags() -> Array[Constants.TAG]:
	return tags

func get_ablity_name() -> String:
	return ability_name

func get_property() -> String: 
	return "No property"

func get_copy() -> Ability: 
	print("this method must be implemented")
	return null
