class_name BodyEnteredBehavior
extends Object

var parent : Node 

func _init(parent : Node) -> void: 
	self.parent = parent

func body_entered(body : Node) -> void:
	push_error("Método 'clamp_speed' no implementado en la subclase.")
