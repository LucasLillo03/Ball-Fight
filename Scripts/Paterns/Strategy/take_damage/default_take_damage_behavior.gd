class_name DefaultTakeDamageBehavior
extends TakeDamageBehavior

func take_damage(bodyEntered : Node, receptorBody : Node) -> int:
	var damage = bodyEntered.get_damage() 
	
	receptorBody.life -= damage
	
	return damage
