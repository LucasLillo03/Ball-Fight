class_name ActivatableAbility
extends Ability

var active := false
var activation_strategy : ActivationStrategy

func _init() -> void:
	activation_strategy = BallContext.activationStrategies.keys().pick_random().new()
	activation_strategy.setup(self)
	
func on_active() -> void: pass

func on_desactive() -> void: pass

func on_update(delta) -> void: if activation_strategy: activation_strategy.update(delta)
