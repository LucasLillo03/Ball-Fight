class_name ShieldTakeDamage
extends TakeDamageBehavior

## toma damage ignorando el total de shield 
var shield : int 
var last_damage : int 

func _init(shield : int) -> void:
	self.shield = shield

func take_damage(body_entered : Node, receptor_body : Node) -> int :
	var damage = body_entered.get_damage()
	var true_damage = max(0, damage - shield)
	
	receptor_body.life -= true_damage
	
	return damage
