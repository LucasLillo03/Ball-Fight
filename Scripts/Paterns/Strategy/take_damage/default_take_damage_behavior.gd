class_name DefaultTakeDamageBehavior
extends TakeDamageBehavior

func take_damage(bodyEntered : Node, receptorBody : Node) -> void: 
	receptorBody.life -= bodyEntered.get_damage()
