class_name ExclusiveTakeDamage
extends TakeDamageBehavior

var exclusives : Array = []

func _init(exclusives : Array) -> void:
	self.exclusives = exclusives

func take_damage(bodyEntered : Node, receptorBody : Node) -> void: 
	if exclusives.has(bodyEntered) : return
	receptorBody.life -= bodyEntered.get_damage()
