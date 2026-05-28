class_name ActivatableAbility
extends Ability

var active := false
var activation_strategy : ActivationStrategy

func _init() -> void:
	activation_strategy = BallContext.activationStrategies.keys().pick_random().new()
	activation_strategy.setup_random_ball(self)
	
func on_active() -> void: 
	active = true

func on_desactive() -> void: active = false

func on_update(delta) -> void: if activation_strategy: activation_strategy.update(delta)
