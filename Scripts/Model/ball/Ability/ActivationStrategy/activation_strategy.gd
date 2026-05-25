class_name ActivationStrategy
extends RefCounted

var ability : Ability
var ball : Ball
	
func setup(ability : ActivatableAbility) -> void: 
	self.ability = ability
	ability.ball_asigned.connect(ball_asigned)
	ability.ball_asigned.connect(on_ready_ball)

func ball_asigned() -> void: 
	ball = ability.ball
	ball.ready.connect(on_ready_ball)

func on_ready_ball() -> void: 
	concrete_setup()
	
func concrete_setup() -> void: 
	pass 

func update(delta) -> void: 
	pass
