class_name Ball
extends RigidBody2D

@export var ball_name := "SIMPLE BALL"

var stats : BallStats = BallStats.new():
	set(value): 
		stats = value 
		if not stats.dead.is_connected(die):
			stats.dead.connect(die)
		stats_changed.emit()
		stats.update_stats()

var ability_system: AbilitySystem

@onready var visuals := $Visuals

var bound_sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var clamp_speed_behavior : ClampSpeedBehavior
var scenery : Map

var movement_locked := false 
var gravity_locked := false

signal damage_blocked
signal i_die
signal stats_changed

func _init() -> void:
	GameState.game_over.connect(game_over_actions)
	ability_system = AbilitySystem.new()
	ability_system.setup(self)

func _ready() -> void:
	add_child(bound_sound_player)
	bound_sound_player.stream = Constants.BOUND_SOUND
	
	initialization()
	
	for ability in ability_system.abilities: 
		ability.on_ready()
	
	z_index = 1
	
	stats.update_stats()

	print("[Ball] ", name, " pos=", global_position, " radius=", stats.radius)

#initialize characteristics 
func initialization() -> void:
	contact_monitor = true
	max_contacts_reported = 8
	body_entered.connect(_on_body_entered)
	
func _physics_process(delta: float) -> void:
	ability_system.update_abilities(delta)
	
	if movement_locked:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0

	if gravity_locked:
		apply_central_force(-get_gravity() * mass)
		
func die() -> void: 
	i_die.emit()
		
	queue_free()

#executes the actions when the game ends
func game_over_actions() -> void: 
	set_deferred("freeze", true)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		var ball : Ball = body
		
		var damage_context = DamageContext.new()
		damage_context.amount = ball.get_damage()
		damage_context.source = body
		
		take_damage(damage_context)
	else: 
		bound_sound_player.play()
	linear_velocity = Vector2.ZERO if movement_locked else clamp_speed_behavior.clamp_speed(linear_velocity)

func take_damage(damage_context : DamageContext):
	ability_system.abilities_take_damage(damage_context)
	if damage_context.cancelled: return 
	
	stats.life -= damage_context.amount

func get_damage() -> int: 
	var amount := stats.damage
	var damage_context = DamageContext.new()
	
	damage_context.amount = amount
		
	return ability_system.abilities_get_damage(amount, damage_context)

func get_ball_name() -> String: 
	return ball_name

func get_properties() -> String:
	return str("Life: " , max(0, stats.life), "\nDamage: ", stats.damage , ability_system.abilities_properties())

#config methods
func get_config() -> BallConfig: 
	var config = BallConfig.new()
	
	config.ball_name = ball_name
	
	for ability in ability_system.abilities: 
		config.abilities.append(ability.get_copy())
	
	config.speed_behavior = clamp_speed_behavior.get_copy() #TODO must be implemented

	config.stats = stats
	
	return config

func set_config(config : BallConfig) -> void: 
	clamp_speed_behavior = config.speed_behavior
	stats = config.stats
	
	#is iterated by item because the method add_ability initializes correctly each ability  
	for ability in config.abilities: 
		ability_system.add_ability(ability) 
	
	ball_name = config.ball_name
