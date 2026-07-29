class_name BallCreator
extends ActivatableAbility

var clones : Array[Ball] = []
var spawn_ray : RayCast2D
var pending_spawn := false 
var create_ball_config : BallConfig

#NOTE this is the main method of the creator abilities
func rand_ball_config() -> BallConfig: 
	var config = BallConfig.new()
	
	config.ball_name = "Clone"
	config.color = ball.color
	config.abilities.append(IgnoreBall.new(clones))
	config.radius = ball.rand_radius()
	config.damage = ball.rand_damage()
	config.speed_behavior = AcceleratedAndLimited.new(Constants.BOOST_FACTOR, ball.max_speed)
	
	return config

func _init() -> void:
	super()
	
	ability_name = "Ball Creator"
	requires_update = true
	
	tags.append(Constants.TAG.BALL_CREATOR)
	
	spawn_ray = RayCast2D.new()
	
	ball_asigned.connect(_on_ball_asigned)
	
	
func _on_ball_asigned() -> void:
	var clones_game_over = func (): 
		for clone in clones: 
			if clone && clone != ball: clone.game_over_actions()
	
	var the_queen_is_dead = func (): 	
		for clone in clones: 
			if clone && clone != ball: clone.die()
	
	clones.append(ball)
	
	spawn_ray.global_position = ball.global_position
	spawn_ray.target_position = Vector2(0.0, ball.radius + 20)
	
	
	
	ball.add_child(spawn_ray)
	GameState.game_over.connect(clones_game_over)
	ball.i_die.connect(the_queen_is_dead)
	ball.ability_system.add_ability(IgnoreBall.new(clones))
	
	create_ball_config = rand_ball_config()

func on_update(delta: float) -> void:
	super(delta)
	spawn_ray.rotate(0.1) 
	
	if pending_spawn:
		try_spawn()

	#if clones.is_empty(): crown.visible = false
	#else: crown.visible = true

func _rand_size() -> float:
	return randf_range(Constants.MIN_INITIAL_RADIUS / 2, Constants.MAX_INITIAL_RADIUS / 2)

func on_active(): 
	super()
	
	pending_spawn = true

func try_spawn() -> void: 
	if !spawn_ray.is_colliding():
			create_ball()
			pending_spawn = false 

func create_ball() -> Ball: 	
	var created_ball = BallFactory.create_from_config(create_ball_config)
	var spawn_pos = spawn_ray.to_global(spawn_ray.target_position)
	
	ball.add_child(created_ball)
	created_ball.global_position = spawn_pos
	
	var dir = (spawn_pos - ball.global_position).normalized()
	created_ball.linear_velocity = dir * 500.0
	
	var clone_die = func():
		clones.erase(created_ball)
	
	clones.append(created_ball)
	created_ball.i_die.connect(clone_die)
	
	return created_ball

func get_property() -> String:
	var string = str("balls created: ", clones.size() - 1)
	
	return string
	
func get_copy() -> Ability: 
	var copy = BallCreator.new()
	
	copy.clones = clones.duplicate()
	copy.spawn_ray = spawn_ray.duplicate()
	copy.create_ball_config = create_ball_config
	
	return copy
