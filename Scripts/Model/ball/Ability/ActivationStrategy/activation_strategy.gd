class_name ActivationStrategy
extends RefCounted

var ability : Ability
var ball : Ball

#sets ability associate to this strategy
func setup(ability : ActivatableAbility) -> void: 
	self.ability = ability
	ability.ball_asigned.connect(ball_asigned)

#sets a config for a new ball
func setup_random_ball(ability : ActivatableAbility) -> void: 
	self.ability = ability
	ability.ball_asigned.connect(ball_asigned_random)

#executes ball config when the  ball is asigned
func ball_asigned() -> void: 
	ball = ability.ball
	ball.ready.connect(on_ready_ball)

func ball_asigned_random() -> void: 
	ball = ability.ball
	ball.ready.connect(on_ready_ball_random)

#execute actions when the ball is in scene  
func on_ready_ball() -> void: 
	concrete_setup()

func on_ready_ball_random() -> void: 
	rand_stats()
	concrete_setup()

#initialize a new random stats for concrete strategy
func rand_stats() -> void: 
	pass

#concrete configuration of child class
func concrete_setup() -> void: 
	pass 

#executes actions in delta time
func update(delta) -> void: 
	pass

func get_copy() -> ActivationStrategy: 
	print("this method must be implemented")
	return null
