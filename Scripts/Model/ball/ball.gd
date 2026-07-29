class_name Ball
extends RigidBody2D

@export var ball_name := "SIMPLE BALL"

var stats : BallStats = BallStats.new()

@export_range(8, 128, 1) var segments: int = 32
@onready var poly: Polygon2D = $Polygon2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var icon_manager := $IconManager

var bound_sound_player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()

var clamp_speed_behavior : ClampSpeedBehavior
var scenery : Map

var ability_system: AbilitySystem

var movement_locked := false 
var gravity_locked := false

signal damage_blocked
signal i_die

func _init() -> void:
	GameState.game_over.connect(game_over_actions)
	ability_system = AbilitySystem.new()
	ability_system.setup(self)

	stats.color_changed.connect(on_color_changed)
	stats.radius_changed.connect(on_radius_changed)

#set the attributes of a new ball
func setting(color : Color, radius : float, damage : int, life : int, clamp_speed : ClampSpeedBehavior) -> void: 
	self.color = color
	self.radius = radius
	self.damage = damage
	self.life = life
	self.clamp_speed_behavior = clamp_speed

func _ready() -> void:
	add_child(bound_sound_player)
	bound_sound_player.stream = Constants.BOUND_SOUND
	
	initialization()
	
	for ability in ability_system.abilities: 
		ability.on_ready()
	
	z_index = 1
	
	stats.update_stats()

#initialize characteristics 
func initialization() -> void:
	update_visual()
	
	_update_collision()
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
		

func _process(delta: float) -> void:
	if is_dead(): 
		die()

#manages dead conditions
func is_dead() -> bool: 
	return stats.life <= 0

#manages dead actions
func die() -> void: 
	i_die.emit()
		
	queue_free()

#executes the actions when the game ends
func game_over_actions() -> void: 
	freeze = true

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


#region set form
func on_radius_changed() -> void:
	if is_instance_valid(poly):
		update_visual()
		_update_collision()

func on_color_changed() -> void: 
	if is_instance_valid(poly):
		poly.color = stats.color

func update_visual() -> void:
	var pts: PackedVector2Array = PackedVector2Array()
	for i in range(segments):
		var a := TAU * float(i) / float(segments)
		pts.append(Vector2(cos(a), sin(a)) * stats.radius)
	poly.polygon = pts
	poly.color = stats.color

func _update_collision() -> void:
	var shape := CircleShape2D.new()
	shape.radius = stats.radius
	collision.shape = shape
#endregion

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
