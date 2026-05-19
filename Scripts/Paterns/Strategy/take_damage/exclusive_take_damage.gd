class_name ExclusiveTakeDamage
extends TakeDamageBehavior

##excluye determinados objetos al recibir daño 

var exclusives : Array = []

func _init(exclusives : Array) -> void:
	self.exclusives = exclusives

func take_damage(bodyEntered : Node, receptorBody : Node) -> int : 
	if exclusives.has(bodyEntered) : return 0
	
	var damage = bodyEntered.get_damage()
	receptorBody.life -= damage
	
	return damage
	
	
